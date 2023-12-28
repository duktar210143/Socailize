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
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // Enable auto-validation
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: 20,
          fontWeight:FontWeight.w700, 
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: color ?? Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Default border color
              width: 4.0, // Default border width
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Border color for invalid input
              width: 4.0, // Border width for invalid input
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Colors.red, // Border color when field is focused and invalid
              width: 4.0, // Border width when field is focused and invalid
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Colors.green, // Border color when field is focused and valid
              width: 4.0, // Border width when field is focused and valid
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
