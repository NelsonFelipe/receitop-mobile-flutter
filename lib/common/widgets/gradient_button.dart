import 'package:flutter/material.dart';


class GradientButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  const GradientButton({
    required this.label,
    this.enabled = true,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: enabled
                ? LinearGradient(
                    colors: [const Color.fromARGB(255, 39, 128, 63), const Color.fromARGB(255, 29, 223, 42)],
                  )
                : null,
            color: enabled ? null : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
