import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../widgets/auth_input_field.dart';

/// Registration form reused inside RegisterPage.
class RegisterFormView extends StatefulWidget {
  const RegisterFormView({super.key});

  @override
  State<RegisterFormView> createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitRegister() {
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<AuthBloc>().add(RegisterRequested(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            AuthInputField(
              controller: _emailController,
              label: 'Email',
            ),
            const SizedBox(height: 12),
            AuthInputField(
              controller: _passwordController,
              label: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 24),
            state is AuthLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submitRegister,
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
