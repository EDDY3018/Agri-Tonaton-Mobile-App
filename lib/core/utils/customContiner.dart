import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'textStyles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: backgroundColor ?? PRIMARY, // 👈 dynamic color
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: CONTAINEERTEXT.copyWith(
            fontSize: 13,
            color: textColor ?? Colors.white, // 👈 dynamic text color
          ),
        ),
      ),
    );
  }
}
