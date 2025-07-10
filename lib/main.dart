import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Auth
import 'features/auth/register/register_controller.dart';
import 'features/auth/register/register_page.dart';
import 'features/auth/login/login_controller.dart';
import 'features/auth/login/login_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 11, 170, 8)),
      ),

      home: const RegisterPage(),
      initialRoute: '/register',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
      }
    );
  }
}
