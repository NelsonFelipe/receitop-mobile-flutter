// lib/features/favorites/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'favorites_controller.dart';
import '../home/widgets/category_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<FavoritesController>();

    // dispara a carga na primeira construção
    if (!ctrl.isLoading && ctrl.favorites.isEmpty && ctrl.error == null) {
      context.read<FavoritesController>().loadFavorites();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Search bar ───────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar favoritos...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey.shade600),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (term) {
                  // opcional: filtrar a lista via controller
                },
              ),
            ),

            const SizedBox(height: 8),

            // ─── Grid de favoritos ───────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ctrl.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ctrl.error != null
                        ? Center(child: Text('Erro: ${ctrl.error}'))
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ctrl.favorites.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, i) {
                              final fav = ctrl.favorites[i];

                              // Usa títulos do controller ou placeholder
                              final title = (i < ctrl.titles.length)
                                  ? ctrl.titles[i]
                                  : 'Receita ${i + 1}';

                              return CategoryCard(
                                title: title,
                                imageUrl: fav.url,
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
