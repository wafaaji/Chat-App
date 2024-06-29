import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final double fontSize;
  final Color textColor;

  const CustomElevatedButton({super.key, 
    required this.onPressed,
    required this.buttonText,
    required this.buttonColor,
    required this.borderRadius,
    this.width,
    required this.height,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
        // child: Text(
        //   buttonText,
        //   style: textStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        child: Text(
            buttonText,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor
          ),
        ),
      ),
    );
  }
}
