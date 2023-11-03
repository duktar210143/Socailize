import 'package:flutter/material.dart';

class textFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color? color;
  const textFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: color ?? Colors.white,
            fontSize: 24,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(80.0), // Adjust the border radius
            borderSide: const BorderSide(
              color: Colors.blue, // Change the border color
              width: 2.0, // Change the border width
            ),
          ),
        ),
      ),
    );
  }
}
