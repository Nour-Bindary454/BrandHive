import 'user_model.dart';

class LoginModel {
  String? message;
  String? accessToken;
  String? refreshToken;
  UserModel? user;

  LoginModel({this.message, this.accessToken, this.refreshToken, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];

    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}
