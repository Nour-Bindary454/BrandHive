part of 'confirm_email_cubit.dart';

abstract class ConfirmEmailState {}

class ConfirmEmailInitial extends ConfirmEmailState {}

class ConfirmEmailLoading extends ConfirmEmailState {}

class ConfirmEmailSuccess extends ConfirmEmailState {}

class ConfirmEmailError extends ConfirmEmailState {
  final String message;

  ConfirmEmailError(this.message);
}
