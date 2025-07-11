// lib/features/recipes/create/widgets/text_input_field.dart
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const TextInputField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
