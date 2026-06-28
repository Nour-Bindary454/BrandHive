abstract class VerifyResetCodeStates {}

class VerifyResetCodeInitial extends VerifyResetCodeStates {}

class VerifyResetCodeLoading extends VerifyResetCodeStates {}

class VerifyResetCodeSuccess extends VerifyResetCodeStates {
  final String message;
  VerifyResetCodeSuccess(this.message);
}

class VerifyResetCodeError extends VerifyResetCodeStates {
  final String message;
  VerifyResetCodeError(this.message);
}
