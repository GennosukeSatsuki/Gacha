import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../domain/models/card_model.dart';

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
      final colors = [
        Colors.amber,
        Colors.white,
        Colors.cyanAccent,
        Colors.purpleAccent,
        Colors.pinkAccent,
      ];
      color = colors[random.nextInt(colors.length)];
    } else {
      color = Colors.amberAccent;
    }
    
    opacity = random.nextDouble() * 0.5 + 0.5;
  }

  void update() {
    x += math.cos(angle) * speed * 0.1;
    y += math.sin(angle) * speed * 0.1;
    rotation += rotationSpeed;
    
    if (x < -0.2 || x > 1.2 || y < -0.2 || y > 1.2) {
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
        canvas.drawShadow(path, particle.color, 4, true);
      }
      
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SparklePainter oldDelegate) => true;
}
