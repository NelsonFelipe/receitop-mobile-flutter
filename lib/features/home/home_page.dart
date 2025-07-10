// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_controller.dart';
import 'widgets/category_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<HomeController>();

    // dispara busca só uma vez
    if (!ctrl.isLoading && ctrl.cats.isEmpty && ctrl.error == null) {
      context.read<HomeController>().loadCats();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // 1) Removemos a barra vazia. Em vez dela, usamos apenas um pequeno espaço.
            const SizedBox(height: 8),

            // 2) Search Field levíssima no topo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar receitas...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 3) Agora o Grid começa mais acima:
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ctrl.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ctrl.error != null
                        ? Center(child: Text('Erro: ${ctrl.error}'))
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: ctrl.cats.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, i) {
                              final cat = ctrl.cats[i];
                              final title = (i < ctrl.categories.length)
                                  ? ctrl.categories[i]
                                  : 'Categoria ${i + 1}';
                              return CategoryCard(
                                title: title,
                                imageUrl: cat.url,
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
