import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  final bool? enabled;
  final double? widthFactor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.padding = const EdgeInsets.symmetric(horizontal: 25.0),
    this.enabled = true,
    this.widthFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const double minWidth = 500;
    const double maxWidth = 900;

    // Genişlik hesaplama
    double calculatedWidth = screenWidth * (widthFactor ?? 1.0);

    // Minimum ve maksimum sınırları uygula
    calculatedWidth = calculatedWidth.clamp(minWidth, maxWidth);

    return Center(
      // Merkeze alma
      child: ConstrainedBox(
        // Sınırları uygulama
        constraints: BoxConstraints(
          maxWidth: calculatedWidth,
          minWidth: minWidth,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            enabled: enabled,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
