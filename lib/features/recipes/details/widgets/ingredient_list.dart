import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientList extends StatelessWidget {
  final List<String> ingredients;
  const IngredientList(this.ingredients, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredientes',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...ingredients.map((ing) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(ing, style: GoogleFonts.inter())),
                ],
              ),
            )),
      ],
    );
  }
}
