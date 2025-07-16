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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Card principal com glassmorphism effect
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo com animação sutil
                        Hero(
                          tag: 'logo',
                          child: Container(
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 32),
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        // Título de boas-vindas
                        const Text(
                          'Bem-vindo de volta!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          'Entre na sua conta para descobrir receitas incríveis',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Campo de email modernizado
                        _ModernInputField(
                          label: 'E-mail',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: ctrl.updateEmail,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Campo de senha modernizado
                        _ModernInputField(
                          label: 'Senha',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          onChanged: ctrl.updatePassword,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        const SizedBox(height: 32),
                        
                        // Botão de login modernizado
                        _ModernButton(
                          label: 'Entrar',
                          enabled: ctrl.canSubmit,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text('Bem-vindo!'),
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
                        
                        // Divisor "ou"
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[300])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'ou',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[300])),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Link para registro
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Não tem conta? ',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/register'),
                              child: const Text(
                                'Cadastre-se',
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget personalizado para campos de entrada modernos
class _ModernInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;

  const _ModernInputField({
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<_ModernInputField> createState() => _ModernInputFieldState();
}

class _ModernInputFieldState extends State<_ModernInputField> {
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? const Color(0xFF2E7D32) : Colors.grey[300]!,
          width: _isFocused ? 2 : 1,
        ),
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: TextFormField(
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText && !_showPassword,
          onChanged: widget.onChanged,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: _isFocused ? const Color(0xFF2E7D32) : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: _isFocused ? const Color(0xFF2E7D32) : Colors.grey[600],
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget personalizado para botão moderno
class _ModernButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  const _ModernButton({
    required this.label,
    required this.enabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: enabled
            ? const LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: enabled ? null : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: enabled ? onPressed : null,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: enabled ? Colors.white : Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
