import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color? color;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.color,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // Enable auto-validation
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          hintStyle: TextStyle(
            color: color ?? Colors.white.withOpacity(0.7),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          filled: true,
          fillColor: color ?? Colors.grey.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color ?? Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
