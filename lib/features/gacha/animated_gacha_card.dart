import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'gacha_card_state.dart';
import 'card_widget.dart';
import 'card_back_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(AnimatedGachaCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger flip animation when card is revealed
    if (oldWidget.cardState.revealState == CardRevealState.faceDown &&
        widget.cardState.revealState == CardRevealState.revealed) {
      _controller.forward();
    }
    
    // Reset animation when card goes back to face down
    if (oldWidget.cardState.revealState == CardRevealState.revealed &&
        widget.cardState.revealState == CardRevealState.faceDown) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 150,
        height: 210,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final angle = _flipAnimation.value;
            final scale = _scaleAnimation.value;
            
            // Determine which side to show
            final showFront = angle > math.pi / 2;
            
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
