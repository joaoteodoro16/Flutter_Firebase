import 'package:flutter/material.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  final String label;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const AppTextFormFieldWidget({ super.key, required this.label, this.obscureText = false, this.validator, this.controller });

   @override
   Widget build(BuildContext context) {
       return TextFormField(
          obscureText: obscureText!,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(),
          ),
       );
  }
}