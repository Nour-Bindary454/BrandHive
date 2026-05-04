abstract class ChangePassState {}

class ChangePassInitial extends ChangePassState {}

class ChangePassLoading extends ChangePassState {}

class ChangePassSuccess extends ChangePassState {
  final String message;
  ChangePassSuccess(this.message);
}

class ChangePassFailure extends ChangePassState {
  final String error;
  ChangePassFailure(this.error);
}
