import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_controller.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<RegisterController>();
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E7D32), // Verde mais escuro e sofisticado
              Color(0xFF4CAF50), // Verde médio
              Color(0xFF81C784), // Verde claro
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Título de boas-vindas
                const Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Junte-se a nós e descubra receitas incríveis',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // Campo Nome
                _ModernInputField(
                  label: 'Nome',
                  icon: Icons.person_outline,
                  onChanged: ctrl.updateName,
                ),
                
                const SizedBox(height: 20),
                
                // Campo Email
                _ModernInputField(
                  label: 'E-mail',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: ctrl.updateEmail,
                ),
                
                const SizedBox(height: 20),
                
                // Campo Senha
                _ModernInputField(
                  label: 'Senha',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  onChanged: ctrl.updatePassword,
                ),
                
                const SizedBox(height: 20),
                
                // Campo Confirmar Senha
                _ModernInputField(
                  label: 'Confirme a senha',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  onChanged: ctrl.updateConfirmPassword,
                ),
                
                const SizedBox(height: 24),
                
                // Mensagem de erro
                if (ctrl.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            ctrl.errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                
                // Botão de cadastro
                _ModernButton(
                  label: ctrl.isLoading ? 'Cadastrando...' : 'Cadastrar',
                  enabled: ctrl.canSubmit && !ctrl.isLoading,
                  isLoading: ctrl.isLoading,
                  onPressed: () {
                    if (!ctrl.canSubmit) return;
                    
                    ctrl.submitRegistration().then((_) {
                      if (ctrl.errorMessage == null) {
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(ctrl.errorMessage!),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                    });
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Divisor "ou"
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.white.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'ou',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white.withOpacity(0.3)),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Link para login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já tem conta? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 55),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFocused ? Colors.white : Colors.white.withOpacity(0.3),
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
            color: Color(0xFF2E7D32),
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

class _ModernButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _ModernButton({
    required this.label,
    required this.enabled,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
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
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      color: enabled ? const Color(0xFF2E7D32) : Colors.grey[600],
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
