// lib/features/auth/register/register_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_controller.dart';
import 'widgets/input_field.dart';
import '../../../common/widgets/gradient_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RegisterController>();

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
                // Campos de input
                InputField(
                  label: 'Nome',
                  prefixIcon: Icons.person,
                  onChanged: ctrl.updateName,
                ),
                const SizedBox(height: 16),
                InputField(
                  label: 'E‑mail',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: ctrl.updateEmail,
                ),
                const SizedBox(height: 16),
                InputField(
                  label: 'Senha',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  onChanged: ctrl.updatePassword,
                ),
                const SizedBox(height: 16),
                InputField(
                  label: 'Confirme a senha',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  onChanged: ctrl.updateConfirmPassword,
                ),
                const SizedBox(height: 24),

                // Mensagem de erro
                if (ctrl.errorMessage != null) ...[
                  Text(
                    ctrl.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],

                // Botão de cadastro
                    GradientButton(
                      label: ctrl.isLoading ? 'Cadastrando...' : 'Cadastrar',
                      enabled: ctrl.canSubmit,
                      onPressed: () {
                        if (!ctrl.canSubmit) return;            // bloqueia quando precisar
                        ctrl.submitRegistration().then((_) {
                          if (ctrl.errorMessage == null) {
                            Navigator.pushReplacementNamed(context, '/login');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(ctrl.errorMessage!)),
                            );
                          }
                        });
                      },
                    ),

                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text('Já tem conta? Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
