import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
import '../register/widgets/input_field.dart';
import '../../../common/widgets/gradient_button.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<LoginController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 17, 240, 62),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 140,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                InputField(
                  label: 'E‑mail',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: ctrl.updateEmail,
                ),
                const SizedBox(height: 16),

                InputField(
                  label: 'Senha',
                  obscureText: true,
                  onChanged: ctrl.updatePassword,
                ),
                const SizedBox(height: 32),

                GradientButton(
                  label: 'Entrar',
                  enabled: ctrl.canSubmit,
                  onPressed: () {
                    // Login simulado
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Bem‑vindo!'),
                        content: Text('Você entrou como ${ctrl.email}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

            // Link para ir ao registro
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text(
                    'Não tem conta? Cadastre‑se',
                    style: TextStyle(color: const Color.fromARGB(255, 12, 169, 25)
                    )
                  ),
                ),
              ],
            )   
          )
        ),
      ),
    );
  }
}
