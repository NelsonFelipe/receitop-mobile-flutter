import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Auth
import 'features/auth/register/register_controller.dart';
import 'features/auth/register/register_page.dart';
import 'features/auth/login/login_controller.dart';
import 'features/auth/login/login_page.dart';

// Home
import 'features/home/home_controller.dart';
import 'features/home/home_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => HomeController()),

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
      initialRoute: '/home',
      routes: {
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      }
    );
  }
}
