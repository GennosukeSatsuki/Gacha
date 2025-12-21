import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/models/card_model.dart';
import 'widgets/sparkle_painter.dart';

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
