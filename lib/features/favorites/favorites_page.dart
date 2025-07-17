// lib/features/favorites/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../recipes/details/recipe_details_page.dart'; // importa a página de detalhes
import 'favorites_controller.dart';
import '../home/widgets/recipe_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesController>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<FavoritesController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
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
                onChanged: (term) {},
              ),
            ),

            const SizedBox(height: 8),

            // Grid de favoritos
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
                              return RecipeCard(
                                title: fav.name,
                                imageUrl: fav.imageUrl,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeDetailsPage(
                                        recipeId: fav.id,
                                        title: fav.name,
                                        imageUrl: fav.imageUrl ?? '',
                                      ),
                                    ),
                                  );
                                },
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
