import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_controller.dart';
import 'widgets/input_field.dart';
import '../../../common/widgets/gradient_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RegisterController>();

    return Scaffold(
      // removemos o appBar default para deixar o gradiente chegar ao topo
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
                // 1) Ilustração ou logo
                SizedBox(
                  height: 140,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                // 2) Título mais destacado
                Text(
                  'Cadastrar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 32),

                // 3) Campos de input com ícones e fundo branco
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
                const SizedBox(height: 32),

                // 4) Botão com gradiente
                GradientButton(
                  label: 'Cadastrar',
                  enabled: ctrl.canSubmit,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Sucesso'),
                        content: const Text('Cadastro simulado concluído!'),
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

                // 5) Link de navegação para login
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Text(
                    'Já tem conta? Entrar',
                    style: TextStyle(color: const Color.fromARGB(255, 12, 169, 25)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
