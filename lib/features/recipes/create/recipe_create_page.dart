// lib/features/recipes/create/recipe_create_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'recipe_create_controller.dart';
import 'widgets/image_picker_field.dart';
import 'widgets/text_input_field.dart';
import 'widgets/dynamic_list_field.dart';

class RecipeCreatePage extends StatelessWidget {
  const RecipeCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RecipeCreateController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Receita')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImagePickerField(
              imageFile: ctrl.imageFile,
              onImagePicked: ctrl.pickImage,
            ),
            const SizedBox(height: 16),

            TextInputField(
              label: 'Nome da Receita',
              value: ctrl.name,
              onChanged: ctrl.updateName,
            ),
            const SizedBox(height: 16),

            TextInputField(
              label: 'Descrição',
              value: ctrl.description,
              onChanged: ctrl.updateDescription,
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            DynamicListField(
              title: 'Ingredientes',
              items: ctrl.ingredients,
              onAdd: ctrl.addIngredient,
              onRemove: ctrl.removeIngredient,
              onChanged: ctrl.updateIngredient,
            ),
            const SizedBox(height: 16),

            DynamicListField(
              title: 'Modo de Preparo',
              items: ctrl.steps,
              onAdd: ctrl.addStep,
              onRemove: ctrl.removeStep,
              onChanged: ctrl.updateStep,
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: ctrl.canSubmit ? () async {
                try {
                  await ctrl.saveRecipe();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Receita criada com sucesso!')),
                  );
                  Navigator.pushReplacementNamed(context, '/app'); // Redireciona para a tela principal
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao criar receita: ${e.toString()}')),
                  );
                }
              } : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: ctrl.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('Salvar', style: GoogleFonts.inter(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
