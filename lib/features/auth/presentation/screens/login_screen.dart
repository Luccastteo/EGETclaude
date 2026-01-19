import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

/// Login Screen with animated error message
class LoginScreen extends ConsumerStatefulWidget {
    const LoginScreen({super.key});

    @override
    ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
      with SingleTickerProviderStateMixin {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    bool _isLoading = false;
    bool _obscurePassword = true;
    String? _emailError;
    bool _showAlmostThere = false;

    late AnimationController _shakeController;
    late Animation<double> _shakeAnimation;

    @override
    void initState() {
          super.initState();
          _shakeController = AnimationController(
                  duration: const Duration(milliseconds: 500),
                  vsync: this,
                );
          _shakeAnimation = Tween<double>(begin: 0, end: 10)
                    .chain(CurveTween(curve: Curves.elasticIn))
                    .animate(_shakeController);
    }

    @override
    void dispose() {
          _emailController.dispose();
          _passwordController.dispose();
          _shakeController.dispose();
          super.dispose();
    }

    void _onEmailChanged(String value) {
          if (_emailError != null) {
                  setState(() => _emailError = null);
          }
          if (_showAlmostThere) {
                  setState(() => _showAlmostThere = false);
          }
    }

    Future<void> _login() async {
          if (!_formKey.currentState!.validate()) return;

          setState(() => _isLoading = true);

          try {
                  // Simulate login - replace with actual Firebase auth
                  await Future.delayed(const Duration(seconds: 1));

                  // Check if email is valid format but wrong
                  final email = _emailController.text.trim();
                  if (!email.contains('@') || !email.contains('.')) {
                            _triggerEmailError();
                            return;
                  }

                  // Navigate to home on success
                  if (mounted) {
                            context.go('/home');
                  }
          } catch (e) {
                  _triggerEmailError();
          } finally {
                  if (mounted) {
                            setState(() => _isLoading = false);
                  }
          }
    }

    void _triggerEmailError() {
          setState(() {
                  _showAlmostThere = true;
                  _emailError = null;
          });
          _shakeController.forward().then((_) => _shakeController.reverse());
    }

    @override
    Widget build(BuildContext context) {
          return Scaffold(
                  backgroundColor: AppColors.background,
                  body: SafeArea(
                            child: SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                      children: [
                                                                                        const SizedBox(height: 60),

                                                                                        // Logo/Title
                                                                                        _buildHeader(),
                                                                                        const SizedBox(height: 48),

                                                                                        // Email Field with animated error
                                                                                        _buildEmailField(),
                                                                                        const SizedBox(height: 16),

                                                                                        // Password Field
                                                                                        _buildPasswordField(),
                                                                                        const SizedBox(height: 8),

                                                                                        // Forgot Password
                                                                                        Align(
                                                                                                            alignment: Alignment.centerRight,
                                                                                                            child: TextButton(
                                                                                                                                  onPressed: () => context.push('/forgot-password'),
                                                                                                                                  child: Text(
                                                                                                                                                          'Esqueceu a senha?',
                                                                                                                                                          style: TextStyle(
                                                                                                                                                                                    color: AppColors.primary,
                                                                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                                                                  ),
                                                                                                                                                        ),
                                                                                                                                ),
                                                                                                          ),
                                                                                        const SizedBox(height: 24),

                                                                                        // Login Button
                                                                                        _buildLoginButton(),
                                                                                        const SizedBox(height: 24),

                                                                                        // Register Link
                                                                                        _buildRegisterLink(),
                                                                                      ],
                                                                    ),
                                                    ),
                                      ),
                          ),
                );
    }

    Widget _buildHeader() {
          return Column(
                  children: [
                            Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                                      color: AppColors.primary,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                        child: const Icon(
                                                      Icons.account_balance_wallet,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                      ),
                            const SizedBox(height: 24),
                            Text(
                                        'EGet',
                                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.textPrimary,
                                                    ),
                                      ),
                            const SizedBox(height: 8),
                            Text(
                                        'Seu contador pessoal inteligente',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: AppColors.textSecondary,
                                                    ),
                                      ),
                          ],
                );
    }

    Widget _buildEmailField() {
          return AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                            return Transform.translate(
                                        offset: Offset(_shakeAnimation.value, 0),
                                        child: child,
                                      );
                  },
                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                        TextFormField(
                                                      controller: _emailController,
                                                      keyboardType: TextInputType.emailAddress,
                                                      onChanged: _onEmailChanged,
                                                      decoration: InputDecoration(
                                                                      labelText: 'E-mail',
                                                                      prefixIcon: const Icon(Icons.email_outlined),
                                                                      errorText: _emailError,
                                                                    ),
                                                      validator: (value) {
                                                                      if (value == null || value.isEmpty) {
                                                                                        return 'Digite seu e-mail';
                                                                      }
                                                                      return null;
                                                      },
                                                    ),

                                        // Animated "Estamos quase la" message
                                        AnimatedSize(
                                                      duration: const Duration(milliseconds: 300),
                                                      child: _showAlmostThere
                                                          ? Padding(
                                                                                padding: const EdgeInsets.only(top: 8, left: 12),
                                                                                child: AnimatedOpacity(
                                                                                                        opacity: _showAlmostThere ? 1.0 : 0.0,
                                                                                                        duration: const Duration(milliseconds: 300),
                                                                                                        child: Text(
                                                                                                                                  'Estamos quase la',
                                                                                                                                  style: TextStyle(
                                                                                                                                                              color: AppColors.primary,
                                                                                                                                                              fontSize: 13,
                                                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                                                            ),
                                                                                                                                ),
                                                                                                      ),
                                                                              )
                                                          : const SizedBox.shrink(),
                                                    ),
                                      ],
                          ),
                );
    }

    Widget _buildPasswordField() {
          return TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                                        icon: Icon(
                                                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                                    ),
                                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                      ),
                          ),
                  validator: (value) {
                            if (value == null || value.isEmpty) {
                                        return 'Digite sua senha';
                            }
                            if (value.length < 6) {
                                        return 'Senha deve ter pelo menos 6 caracteres';
                            }
                            return null;
                  },
                );
    }

    Widget _buildLoginButton() {
          return ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ),
                                    )
                      : const Text('Entrar'),
                );
    }

    Widget _buildRegisterLink() {
          return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                            Text(
                                        'Nao tem uma conta? ',
                                        style: TextStyle(color: AppColors.textSecondary),
                                      ),
                            TextButton(
                                        onPressed: () => context.push('/register'),
                                        child: Text(
                                                      'Cadastre-se',
                                                      style: TextStyle(
                                                                      color: AppColors.primary,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                    ),
                                      ),
                          ],
                );
    }
}
