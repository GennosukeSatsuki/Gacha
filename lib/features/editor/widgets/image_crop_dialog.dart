import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageCropDialog extends StatefulWidget {
  final Uint8List imageBytes;
  final double aspectRatio;

  const ImageCropDialog({
    super.key,
    required this.imageBytes,
    required this.aspectRatio,
  });

  @override
  State<ImageCropDialog> createState() => _ImageCropDialogState();
}

class _ImageCropDialogState extends State<ImageCropDialog> {
  final _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('CROP IMAGE', style: GoogleFonts.philosopher(color: const Color(0xFFD4AF37))),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => _controller.crop(),
            child: const Text('OK', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Crop(
        image: widget.imageBytes,
        controller: _controller,
        onCropped: (result) {
          switch (result) {
            case CropSuccess(:final croppedImage):
              Navigator.pop(context, croppedImage);
            case CropFailure():
              // Handle error if needed
              break;
          }
        },
        aspectRatio: widget.aspectRatio,
        maskColor: Colors.black.withOpacity(0.8),
        interactive: true,
      ),
    );
  }
}
