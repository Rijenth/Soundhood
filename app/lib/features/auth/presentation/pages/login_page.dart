import 'package:flutter/material.dart';
import '../views/login_form_view.dart';
import '../../../../core/widgets/logo_widget.dart';

/// Page for logging in the user.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
          child: Column(
            children: [
              LogoWidget(),
              SizedBox(height: 40),
              LoginFormView(),
            ],
          ),
        ),
      ),
    );
  }
}
