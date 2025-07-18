// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/search_bar_widget.dart';

import '../recipes/details/recipe_details_page.dart';
import 'home_controller.dart';
import 'widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<HomeController>();

    if (!ctrl.isLoading && ctrl.recipes.isEmpty && ctrl.error == null) {
      context.read<HomeController>().loadRecipes();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            SearchBarWidget(
              controller: _searchController,
              hintText: 'Buscar receitas...',
              onChanged: (query) {
                ctrl.filterRecipes(query);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ctrl.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ctrl.error != null
                        ? Center(child: Text('Erro: ${ctrl.error}'))
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ctrl.recipes.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, i) {
                              final recipe = ctrl.recipes[i];
                              return RecipeCard(
                                title: recipe.name,
                                imageUrl: recipe.imageUrl,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecipeDetailsPage(
                                        recipeId: recipe.id,
                                        title: recipe.name,
                                        imageUrl: recipe.imageUrl ?? '',
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
