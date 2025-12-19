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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E),
            const Color(0xFF0F0F1E),
            const Color(0xFF16213E),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _CardBackPatternPainter(),
            ),
          ),
          
          // Center emblem
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD4AF37).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 60,
                    color: Color(0xFFD4AF37),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '?',
                  style: GoogleFonts.philosopher(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFD4AF37),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Corner decorations
          Positioned(
            top: 12,
            left: 12,
            child: _CornerDecoration(),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Transform.rotate(
              angle: 1.5708, // 90 degrees
              child: _CornerDecoration(),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Transform.rotate(
              angle: -1.5708, // -90 degrees
              child: _CornerDecoration(),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Transform.rotate(
              angle: 3.14159, // 180 degrees
              child: _CornerDecoration(),
            ),
          ),
        ],
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
