import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/models/card_model.dart';

class SparkleEffect extends StatefulWidget {
  final CardRarity rarity;
  final bool isActive;

  const SparkleEffect({
    super.key,
    required this.rarity,
    required this.isActive,
  });

  @override
  State<SparkleEffect> createState() => _SparkleEffectState();
}

class _SparkleEffectState extends State<SparkleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<SparkleParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _initParticles();
  }

  void _initParticles() {
    _particles.clear();
    int count = 0;
    if (widget.rarity == CardRarity.mythic) {
      count = 40;
    } else if (widget.rarity == CardRarity.rare) {
      count = 15;
    }

    for (int i = 0; i < count; i++) {
      _particles.add(SparkleParticle(
        random: _random,
        rarity: widget.rarity,
      ));
    }
  }

  @override
  void didUpdateWidget(SparkleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rarity != widget.rarity) {
      _initParticles();
    }
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0);
      _controller.repeat();
    } else if (!widget.isActive && oldWidget.isActive) {
      // Keep it until it dies out or just stop?
      // For now, let's just let it stay until the card is reset.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive || (widget.rarity != CardRarity.rare && widget.rarity != CardRarity.mythic)) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SparklePainter(
            particles: _particles,
            progress: _controller.value,
            rarity: widget.rarity,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class SparkleParticle {
  late double x;
  late double y;
  late double size;
  late double speed;
  late double angle;
  late Color color;
  late double opacity;
  late double rotation;
  late double rotationSpeed;

  SparkleParticle({required math.Random random, required CardRarity rarity}) {
    reset(random, rarity);
  }

  void reset(math.Random random, CardRarity rarity) {
    x = random.nextDouble();
    y = random.nextDouble();
    size = random.nextDouble() * (rarity == CardRarity.mythic ? 8.0 : 5.0) + 2.0;
    speed = random.nextDouble() * 0.02 + 0.01;
    angle = random.nextDouble() * math.pi * 2;
    rotation = random.nextDouble() * math.pi * 2;
    rotationSpeed = (random.nextDouble() - 0.5) * 0.2;
    
    if (rarity == CardRarity.mythic) {
      // 彩溢れる色 or ゴールド
      final colors = [
        Colors.amber,
        Colors.white,
        Colors.cyanAccent,
        Colors.purpleAccent,
        Colors.pinkAccent,
      ];
      color = colors[random.nextInt(colors.length)];
    } else {
      // 基本はゴールド
      color = Colors.amberAccent;
    }
    
    opacity = random.nextDouble() * 0.5 + 0.5;
  }

  void update() {
    x += math.cos(angle) * speed * 0.1;
    y += math.sin(angle) * speed * 0.1;
    rotation += rotationSpeed;
    
    if (x < -0.2 || x > 1.2 || y < -0.2 || y > 1.2) {
      // Reset logic would normally be here if we want continuous flow,
      // but for a burst we might handle it differently.
      // For now, let's just wrap around or reset to a random edge.
      x = x < -0.2 ? 1.1 : (x > 1.2 ? -0.1 : x);
      y = y < -0.2 ? 1.1 : (y > 1.2 ? -0.1 : y);
    }
  }
}

class SparklePainter extends CustomPainter {
  final List<SparkleParticle> particles;
  final double progress;
  final CardRarity rarity;

  SparklePainter({
    required this.particles,
    required this.progress,
    required this.rarity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      particle.update();
      
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity * math.sin(progress * math.pi))
        ..style = PaintingStyle.fill;

      final pos = Offset(particle.x * size.width, particle.y * size.height);
      
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(particle.rotation);
      
      // Draw a star-like shape
      final path = Path();
      final halfSize = particle.size / 2;
      path.moveTo(0, -halfSize * 2);
      path.lineTo(halfSize * 0.5, -halfSize * 0.5);
      path.lineTo(halfSize * 2, 0);
      path.lineTo(halfSize * 0.5, halfSize * 0.5);
      path.lineTo(0, halfSize * 2);
      path.lineTo(-halfSize * 0.5, halfSize * 0.5);
      path.lineTo(-halfSize * 2, 0);
      path.lineTo(-halfSize * 0.5, -halfSize * 0.5);
      path.close();
      
      if (rarity == CardRarity.mythic) {
        // Add glow
        canvas.drawShadow(path, particle.color, 4, true);
      }
      
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SparklePainter oldDelegate) => true;
}
