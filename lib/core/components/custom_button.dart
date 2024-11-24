import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final bool isAddButton;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.isAddButton = false,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(25),
        margin: margin ?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: onTap == null ? Colors.grey[400] : Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: onTap == null ? Colors.grey[700] : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
