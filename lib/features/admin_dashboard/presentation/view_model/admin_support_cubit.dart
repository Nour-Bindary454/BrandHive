import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand/features/admin_dashboard/data/repository/admin_repo.dart';
import 'admin_support_state.dart';

class AdminSupportCubit extends Cubit<AdminSupportState> {
  final AdminRepository repository;

  AdminSupportCubit(this.repository) : super(AdminSupportState());

  Future<void> getSupportMessages() async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.getSupportMessages();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.errMessage,
        ));
      },
      (messages) {
        emit(state.copyWith(
          isLoading: false,
          messages: messages,
        ));
      },
    );
  }

  Future<void> replyToMessage(String id, String replyText) async {
    if (replyText.trim().isEmpty) return;

    emit(state.copyWith(isLoading: true));

    final result = await repository.replyToSupportMessage(id, replyText);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.errMessage,
        ));
      },
      (updatedMessage) async {
        final updatedMessages = state.messages.map((m) {
          if (m.id == id) {
            return updatedMessage;
          }
          return m;
        }).toList();

        emit(state.copyWith(
          isLoading: false,
          messages: updatedMessages,
        ));

        // Resolve target user ID (from ticket user field, fallback to email lookup)
        String? targetUserId = updatedMessage.userId;
        debugPrint("🔍 [AdminSupportCubit] Initial userId from updatedMessage: $targetUserId");

        if (targetUserId == null || targetUserId.isEmpty) {
          debugPrint("🔍 [AdminSupportCubit] Falling back to email lookup for email: ${updatedMessage.email}");
          final userResult = await repository.getUserIdByEmail(updatedMessage.email);
          userResult.fold(
            (failure) => debugPrint("❌ [AdminSupportCubit] getUserIdByEmail failed: ${failure.errMessage}"),
            (resolvedId) {
              targetUserId = resolvedId;
              debugPrint("🔍 [AdminSupportCubit] Resolved userId from email fallback: $targetUserId");
            },
          );
        }

        // Send a notification to the user if a valid user ID is resolved
        if (targetUserId != null && targetUserId!.isNotEmpty) {
          debugPrint("🚀 [AdminSupportCubit] Sending support reply notification to userId: $targetUserId");
          final notificationResult = await repository.sendNotification(
            data: {
              "userId": targetUserId!,
              "type": "general",
              "title": "Support Reply",
              "body": replyText,
            },
          );
          notificationResult.fold(
            (failure) => debugPrint("❌ [AdminSupportCubit] sendNotification failed: ${failure.errMessage}"),
            (successMessage) => debugPrint("✅ [AdminSupportCubit] sendNotification succeeded: $successMessage"),
          );
        } else {
          debugPrint("⚠️ [AdminSupportCubit] Cannot send notification. resolved targetUserId is null or empty!");
        }
      },
    );
  }
}
