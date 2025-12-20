import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/models/card_model.dart';
import 'gacha_card_state.dart';
import 'card_widget.dart';
import 'card_back_widget.dart';
import 'sparkle_effect.dart';

class AnimatedGachaCard extends StatefulWidget {
  final GachaCardState cardState;
  final VoidCallback onTap;

  const AnimatedGachaCard({
    super.key,
    required this.cardState,
    required this.onTap,
  });

  @override
  State<AnimatedGachaCard> createState() => _AnimatedGachaCardState();
}

class _AnimatedGachaCardState extends State<AnimatedGachaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late Animation<double> _scaleAnimation;
  bool _isSparkleActive = false;

  @override
  void initState() {
    super.initState();
    
    // レアリティに応じた演出設定
    final rarity = widget.cardState.card.rarity;
    double endAngle = math.pi;
    Duration duration = const Duration(milliseconds: 600);
    
    switch (rarity) {
      case CardRarity.mythic:
        endAngle = math.pi * 11; // 5回転 + 半回転
        duration = const Duration(milliseconds: 2000);
        break;
      case CardRarity.rare:
        endAngle = math.pi * 7;  // 3回転 + 半回転
        duration = const Duration(milliseconds: 1400);
        break;
      case CardRarity.uncommon:
        endAngle = math.pi * 3;  // 1回転 + 半回転
        duration = const Duration(milliseconds: 1000);
        break;
      case CardRarity.common:
        endAngle = math.pi;      // 通常のめくり
        duration = const Duration(milliseconds: 600);
        break;
    }

    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: endAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(AnimatedGachaCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger flip animation when card is revealed
    if (oldWidget.cardState.revealState == CardRevealState.faceDown &&
        widget.cardState.revealState == CardRevealState.revealed) {
      // 演出設定を再計算（レアリティが変わっている可能性に備えて）
      _updateAnimationSettings();
      setState(() {
        _isSparkleActive = true;
      });
      _controller.forward().then((_) {
        // 回転が止まってから0.5秒遅れて星の演出を消す
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _isSparkleActive = false;
            });
          }
        });
      });
    }
    
    // Reset animation when card goes back to face down
    if (oldWidget.cardState.revealState == CardRevealState.revealed &&
        widget.cardState.revealState == CardRevealState.faceDown) {
      _controller.reset();
      setState(() {
        _isSparkleActive = false;
      });
    }
  }

  void _updateAnimationSettings() {
    final rarity = widget.cardState.card.rarity;
    double endAngle = math.pi;
    Duration duration = const Duration(milliseconds: 600);
    
    switch (rarity) {
      case CardRarity.mythic:
        endAngle = math.pi * 11;
        duration = const Duration(milliseconds: 2000);
        break;
      case CardRarity.rare:
        endAngle = math.pi * 7;
        duration = const Duration(milliseconds: 1400);
        break;
      case CardRarity.uncommon:
        endAngle = math.pi * 3;
        duration = const Duration(milliseconds: 1000);
        break;
      case CardRarity.common:
        endAngle = math.pi;
        duration = const Duration(milliseconds: 600);
        break;
    }

    _controller.duration = duration;
    _flipAnimation = Tween<double>(begin: 0, end: endAngle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // キラキラ演出（レア・ミスティックのみ）
        if (_isSparkleActive)
          Positioned(
            left: -50,
            top: -50,
            right: -50,
            bottom: -50,
            child: IgnorePointer(
              child: SparkleEffect(
                rarity: widget.cardState.card.rarity,
                isActive: true,
              ),
            ),
          ),
        GestureDetector(
          onTap: widget.onTap,
          child: SizedBox(
            width: 150,
            height: 210,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final angle = _flipAnimation.value;
                final scale = _scaleAnimation.value;
                
                // Determine which side to show (using modulo for multiple rotations)
                final normalizedAngle = angle % (2 * math.pi);
                final showFront = normalizedAngle > math.pi / 2 && normalizedAngle < 1.5 * math.pi;
                
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..scale(scale)
                    ..rotateY(angle),
                  child: showFront
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: _buildCardFront(),
                        )
                      : _buildCardBack(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardBack() {
    return Hero(
      tag: 'card_${widget.cardState.index}_back',
      child: const CardBackWidget(
        width: 150,
        height: 210,
      ),
    );
  }

  Widget _buildCardFront() {
    return Hero(
      tag: 'card_detail_${widget.cardState.card.id}',
      child: Material(
        color: Colors.transparent,
        child: CardWidget(
          card: widget.cardState.card,
          width: 150,
          height: 210,
        ),
      ),
    );
  }
}
