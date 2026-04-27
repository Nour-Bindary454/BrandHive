import 'package:brand/features/signup/data/model/register_response_model.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class SignUpLoading extends RegisterStates {}

class SignUpSuccess extends RegisterStates {
  final RegisterModel registerModel;
  SignUpSuccess(this.registerModel);
}

class SignUpError extends RegisterStates {
  final String message;
  SignUpError(this.message);
}
