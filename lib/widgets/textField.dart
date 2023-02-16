import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPassword;
  Widget? icon;
  EcoTextField(
      {this.hintText,
      this.validate,
      this.controller,
      this.isPassword = false,
      this.icon});

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? widget.isPassword : false,
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: widget.icon,
          hintText: widget.hintText ?? 'hint text',
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
