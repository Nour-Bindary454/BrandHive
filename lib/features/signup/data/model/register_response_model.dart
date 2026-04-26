class RegisterModel {
  String? message;
  String? userId;

  RegisterModel({this.message, this.userId});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userId'] = userId;
    return data;
  }
}
