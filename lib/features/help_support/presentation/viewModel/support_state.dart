class SupportState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  SupportState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  SupportState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return SupportState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}
