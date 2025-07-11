// lib/features/recipes/create/widgets/dynamic_list_field.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicListField extends StatelessWidget {
  final String title;
  final List<String> items;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;
  final void Function(int index, String value) onChanged;

  const DynamicListField({
    Key? key,
    required this.title,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(items.length, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: items[i],
                    onChanged: (v) => onChanged(i, v),
                    decoration: InputDecoration(
                      hintText: 'Digite aqui',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true, fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (items.length > 1)
                  GestureDetector(
                    onTap: () => onRemove(i),
                    child: Icon(Icons.remove_circle, color: Colors.red.shade400),
                  ),
              ],
            ),
          );
        }),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Adicionar'),
        ),
      ],
    );
  }
}
