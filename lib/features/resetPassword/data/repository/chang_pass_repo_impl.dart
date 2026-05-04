import 'package:brand/core/services/api_services.dart';
import 'package:brand/core/services/end_points.dart';
import 'package:brand/features/resetPassword/data/repository/chang_pass_repo.dart';

class ChangePassRepoImpl implements ChangePassRepo {
  final ApiService apiService;

  ChangePassRepoImpl(this.apiService);

  @override
  Future<String> changePassword({
    required String email,
    required String password,
  }) async {
    final response = await apiService.patchData(
      endPoint: EndPoints.resetPassword,
      data: {"email": email, "newPassword": password},
    );

    return response.data["message"];
  }
}
