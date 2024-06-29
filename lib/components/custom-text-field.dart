import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final InputDecoration decoration;
  final String? defaultText;

  const CustomTextField({super.key, 
    required this.controller,
    required this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    required this.onSaved,
    this.validator,
    required this.decoration,
    this.defaultText,
  }) : assert(obscureText == false || defaultText == null,
  "Cannot set defaultText when obscureText is true.");

  @override
  Widget build(BuildContext context) {

    final isMultiline = keyboardType == TextInputType.multiline;

    if (defaultText != null && controller.text.isEmpty) {
      controller.text = defaultText!;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            onSaved: onSaved,
            validator: validator,
            decoration: decoration.copyWith(
              hintText: decoration.hintText,
              contentPadding: isMultiline
                  ? const EdgeInsets.symmetric(vertical: 10.0)
                  : null,
              alignLabelWithHint: isMultiline,
            ),
            cursorColor: const Color(0xFFBE0B0B),
            maxLines: isMultiline ? null : 1,
          ),
        ),
      ),
    );
  }
}
