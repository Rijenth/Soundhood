import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/register_form_model.dart';

/// Handles multi-step registration form state.
class RegisterCubit extends Cubit<RegisterFormModel?> {
  RegisterCubit() : super(null);

  /// Stores the completed form after step 2
  void submitForm(RegisterFormModel model) {
    emit(model);
    // Ici tu pourrais aussi :
    // - Appeler un UseCase
    // - Naviguer vers une page de confirmation
    // - Lancer le RegisterRequested dans un AuthBloc
  }

  /// Reset le state si besoin
  void reset() => emit(null);
}
