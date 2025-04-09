import 'package:flutter/material.dart';
import '../../../../core/widgets/logo_widget.dart';
import '../widgets/auth_buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LogoWidget(),
                SizedBox(height: 60),
                AuthButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}