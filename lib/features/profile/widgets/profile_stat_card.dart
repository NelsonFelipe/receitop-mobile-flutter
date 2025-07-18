import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileStatCard extends StatelessWidget {
  final String label;
  final int value;
  const ProfileStatCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
