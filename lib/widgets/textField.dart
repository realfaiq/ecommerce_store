import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPassword;
  Widget? icon;
  int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  EcoTextField(
      {this.hintText,
      this.validate,
      this.controller,
      this.textInputAction,
      this.focusNode,
      this.isPassword = false,
      this.icon,
      this.maxLines});

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
        // maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
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
