// lib/features/auth/register/widgets/submit_button.dart
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  const SubmitButton({
    required this.label,
    this.enabled = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
