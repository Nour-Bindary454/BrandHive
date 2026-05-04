abstract class ChangePassRepo {
  Future<String> changePassword({
    required String email,
    required String password,
  });
}
