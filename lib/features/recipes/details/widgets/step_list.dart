import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepList extends StatelessWidget {
  final List<String> steps;
  const StepList(this.steps, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Modo de Preparo',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(steps.length, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 10, child: Text('${i+1}', style: GoogleFonts.inter(fontSize: 12))),
                const SizedBox(width: 8),
                Expanded(child: Text(steps[i], style: GoogleFonts.inter())),
              ],
            ),
          );
        }),
      ],
    );
  }
}
