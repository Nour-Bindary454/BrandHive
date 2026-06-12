import 'package:brand/features/admin_dashboard/data/models/admin_support_message_model.dart';

class AdminSupportState {
  final bool isLoading;
  final String? error;
  final List<AdminSupportMessageModel> messages;

  AdminSupportState({
    this.isLoading = false,
    this.error,
    this.messages = const [],
  });

  AdminSupportState copyWith({
    bool? isLoading,
    String? error,
    List<AdminSupportMessageModel>? messages,
  }) {
    return AdminSupportState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      messages: messages ?? this.messages,
    );
  }
}
