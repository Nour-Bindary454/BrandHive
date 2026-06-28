class AdminNotificationState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  AdminNotificationState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  AdminNotificationState copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return AdminNotificationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
    );
  }
}
