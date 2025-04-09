import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/button_widget.dart';
import '../../domain/entities/register_form_model.dart';
import '../../domain/entities/credentials.dart';
import '../blocs/register_cubit.dart';
import '../widgets/register_text_field.dart';
import '../widgets/register_avatar_widget.dart';

/// Second step of the registration, where the user creates their musical profile.
class RegisterSecondPage extends StatefulWidget {
  const RegisterSecondPage({super.key});

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  late final RegisterFormModel formModel;

  final _profileNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instrumentsController = TextEditingController();
  final _influencesController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra == null || extra is! Map<String, dynamic>) {
      throw Exception('Missing registration data from step 1');
    }
    formModel = RegisterFormModel.fromMap(extra);
  }

  void _onSubmit() {
    final completedForm = RegisterFormModel(
      email: formModel.email,
      password: formModel.password,
      firstName: formModel.firstName,
      lastName: formModel.lastName,
      profileName: _profileNameController.text,
      description: _descriptionController.text,
      instruments: _instrumentsController.text,
      influences: _influencesController.text,
    );

    // Appelle le cubit pour stocker le modèle complet
    context.read<RegisterCubit>().submitForm(completedForm);

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
        title: const Text("Créer votre profil", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            const RegisterAvatarWidget(),
            const SizedBox(height: 32),
            RegisterTextField(hint: 'Nom de profil', controller: _profileNameController),
            const SizedBox(height: 16),
            RegisterTextField(hint: 'Description', controller: _descriptionController),
            const SizedBox(height: 16),
            RegisterTextField(hint: 'Instruments joués', controller: _instrumentsController),
            const SizedBox(height: 16),
            RegisterTextField(hint: 'Influences musicales', controller: _influencesController),
            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/auth/welcome'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Annuler"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ButtonWidget(
                    text: "Valider",
                    onPressed: _onSubmit,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
