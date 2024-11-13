import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final XFile? selectedImage;
  final Function(XFile?) onImageSelected;
  final String hintText;
  final EdgeInsets? padding;
  final double? widthFactor;
  final bool enabled;

  const CustomImagePicker({
    super.key,
    this.selectedImage,
    required this.onImageSelected,
    required this.hintText,
    this.padding = const EdgeInsets.symmetric(horizontal: 25.0),
    this.widthFactor = 1.0,
    this.enabled = true,
  });

  Future<void> _pickImage() async {
    if (!enabled) return;

    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        onImageSelected(image);
      }
    } catch (e) {
      debugPrint('Resim seçme hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const double minWidth = 500;
    const double maxWidth = 900;

    double calculatedWidth = screenWidth * (widthFactor ?? 1.0);
    calculatedWidth = calculatedWidth.clamp(minWidth, maxWidth);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: calculatedWidth,
          minWidth: minWidth,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 25.0),
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: enabled ? Colors.white : Colors.grey.shade400,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedImage != null ? 'Logo seçildi' : hintText,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      selectedImage != null
                          ? Icons.check_circle
                          : Icons.add_photo_alternate,
                      color: selectedImage != null
                          ? Colors.green
                          : Colors.grey[500],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
