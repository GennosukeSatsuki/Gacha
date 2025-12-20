import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBackWidget extends StatelessWidget {
  final double width;
  final double height;

  const CardBackWidget({
    super.key,
    this.width = 150,
    this.height = 210,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/cards/back/Card_back.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // エラー時のフォールバック（以前のデザインに近いスタイル）
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A1A2E),
                    const Color(0xFF0F0F1E),
                    const Color(0xFF16213E),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: Color(0xFFD4AF37),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CornerDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.6), width: 2),
          left: BorderSide(color: const Color(0xFFD4AF37).withOpacity(0.6), width: 2),
        ),
      ),
    );
  }
}

class _CardBackPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw diagonal lines pattern
    for (double i = -size.height; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
    
    for (double i = -size.height; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i + 10, 0),
        Offset(i + 10 + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
