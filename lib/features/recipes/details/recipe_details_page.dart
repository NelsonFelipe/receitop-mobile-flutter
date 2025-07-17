import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recipe_details_controller.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String recipeId;
  final String title;
  final String imageUrl;
  final bool isFavoritePage;
  final VoidCallback? onFavoriteToggle;

  const RecipeDetailsPage({
    Key? key,
    required this.recipeId,
    required this.title,
    required this.imageUrl,
    this.isFavoritePage = false,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeDetailsController>().fetchRecipeDetails(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RecipeDetailsController>();

    return Scaffold(
      body: ctrl.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ctrl.error != null
              ? Center(child: Text(ctrl.error!))
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 280,
                      pinned: true,
                      backgroundColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        title: Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(widget.imageUrl, fit: BoxFit.cover),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                  stops: const [0.5, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            Text(ctrl.recipe?.description ?? 'N/A',
                                style: GoogleFonts.inter(
                                    fontSize: 14, height: 1.4)),
                            const SizedBox(height: 24),
                            Text('Ingredientes',
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            if (ctrl.recipe?.ingredients != null)
                              ...ctrl.recipe!.ingredients.map((ing) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle_outline,
                                            size: 20, color: Colors.green),
                                        const SizedBox(width: 8),
                                        Expanded(
                                            child: Text(ing,
                                                style: GoogleFonts.inter())),
                                      ],
                                    ),
                                  )),
                            const SizedBox(height: 24),
                            Text('Modo de Preparo',
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            if (ctrl.recipe?.steps != null)
                              ...List.generate(ctrl.recipe!.steps.length, (i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          '${i + 1}',
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                          child: Text(ctrl.recipe!.steps[i],
                                              style: GoogleFonts.inter())),
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
        onPressed: () => ctrl.toggleFavorite(widget.recipeId),
        backgroundColor: Colors.redAccent,
        child: Icon(
          ctrl.isFavorited ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
    );
  }
}
