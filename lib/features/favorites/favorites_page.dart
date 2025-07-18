// lib/features/favorites/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/widgets/search_bar_widget.dart';

import '../recipes/details/recipe_details_page.dart'; 
import 'favorites_controller.dart';
import '../home/widgets/recipe_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            SearchBarWidget(
              controller: _searchController,
              hintText: 'Buscar favoritos...',
              onChanged: (query) {
                ctrl.filterFavorites(query);
              },
            ),

            const SizedBox(height: 8),

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
                                        isFavoritePage: true,
                                        onFavoriteToggle: () {
                                          context.read<FavoritesController>().loadFavorites();
                                        },
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
