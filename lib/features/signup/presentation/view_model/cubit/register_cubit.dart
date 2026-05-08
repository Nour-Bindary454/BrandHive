import 'package:bloc/bloc.dart';

import 'package:brand/features/signup/data/repository/register_repos.dart';
import 'package:brand/features/signup/presentation/view_model/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.registerRepository) : super(RegisterInitState());

  final RegisterRepository registerRepository;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      emit(SignUpError("Please fill all fields"));
      return;
    }

    if (password != confirmPassword) {
      emit(SignUpError("Passwords do not match"));
      return;
    }

    emit(SignUpLoading());

    try {
      final data = {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      };

      final result = await registerRepository.register(data: data);

      result.fold(
        (failure) {
          emit(SignUpError(failure.errMessage));
        },
        (response) {
          emit(SignUpSuccess(response));
        },
      );
    } catch (e) {
      emit(SignUpError("Something went wrong, please try again"));
    }
  }
}
