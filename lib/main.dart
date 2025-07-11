// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_shell.dart';

// Auth
import 'features/auth/register/register_controller.dart';
import 'features/auth/register/register_page.dart';
import 'features/auth/login/login_controller.dart';
import 'features/auth/login/login_page.dart';

// Outros Controllers (usados dentro do AppShell)
import 'features/home/home_controller.dart';
import 'features/profile/profile_controller.dart';
import 'features/favorites/favorites_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
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
      home: const AppShell(),
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context)    => const LoginPage(),
        '/app': (context)      => const AppShell(),
      },
    );
  }
}
