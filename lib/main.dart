import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/services/auth_service.dart';
import 'app_shell.dart';

// Auth
import 'features/auth/register/register_controller.dart';
import 'features/auth/register/register_page.dart';
import 'features/auth/login/login_controller.dart';
import 'features/auth/login/login_page.dart';

// Recipes
import 'features/recipes/create/recipe_create_controller.dart';
import 'features/recipes/create/recipe_create_page.dart';
import 'features/recipes/details/recipe_details_controller.dart';
import 'features/recipes/recipe_repository.dart';

// Outros Controllers (usados dentro do AppShell)
import 'features/home/home_controller.dart';
import 'features/profile/profile_controller.dart';
import 'features/favorites/favorites_controller.dart';

void main() {
  const String baseUrl = 'http://10.0.2.2:3333';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RegisterController(authService: AuthService(baseUrl: baseUrl))),
        ChangeNotifierProvider(
            create: (_) => LoginController(authService: AuthService(baseUrl: baseUrl))),
        ChangeNotifierProvider(
            create: (_) => HomeController(repository: RecipeRepository(baseUrl: baseUrl))),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProvider(
            create: (_) =>
                RecipeCreateController(recipeRepository: RecipeRepository(baseUrl: baseUrl))),
        ChangeNotifierProvider(create: (_) => RecipeDetailsController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 11, 170, 8),
        ),
      ),

      // Tela inicial: registro
      initialRoute: '/login',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/app': (context) => const AppShell(),
        '/create': (context) => const RecipeCreatePage(),
      },
    );
  }
}
