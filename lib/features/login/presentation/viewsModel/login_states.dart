import 'package:brand/features/login/data/model/login_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final LoginModel model;
  LoginSuccess(this.model);
}

class LoginError extends LoginStates {
  final String message;
  LoginError(this.message);
}
