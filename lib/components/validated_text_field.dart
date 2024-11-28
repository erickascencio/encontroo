import 'package:flutter/material.dart';

class ValidatedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final bool isObscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const ValidatedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(color: Colors.red),
        ),
        validator: validator,
      ),
    );
  }
}
