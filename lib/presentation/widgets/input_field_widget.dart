import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hint;
  final bool isMultiLines;

  const InputFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.hint,
    this.isMultiLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      maxLines: isMultiLines ? 6 : 1,
      validator: validator,
    );
  }
}
