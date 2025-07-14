// lib/features/recipes/details/recipe_details_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isFavoritePage;
  final VoidCallback? onFavoriteToggle;

  const RecipeDetailsPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.isFavoritePage = false,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const description =
        'Uma deliciosa receita de exemplo, perfeita para inspirar o seu próximo jantar!';
    const ingredients = [
      '1 xícara de ingrediente A',
      '2 colheres de sopa de ingrediente B',
      'Sal a gosto',
      'Pitada de especiarias'
    ];
    const steps = [
      'Misturar ingredientes secos.',
      'Adicionar líquidos e mexer.',
      'Cozinhar em fogo médio por 15 minutos.',
      'Servir quente.'
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                ),
              ),
              background: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descrição',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(description,
                      style: GoogleFonts.inter(fontSize: 14, height: 1.4)),
                  const SizedBox(height: 24),
                  Text('Ingredientes',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...ingredients.map((ing) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 20, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(ing, style: GoogleFonts.inter())),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  Text('Modo de Preparo',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...List.generate(steps.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              '${i + 1}',
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Text(steps[i], style: GoogleFonts.inter())),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFavoriteToggle,
        backgroundColor:
            isFavoritePage ? Colors.grey.shade300 : Colors.redAccent,
        child: Icon(
          isFavoritePage ? Icons.delete : Icons.favorite_border,
          color: isFavoritePage ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}