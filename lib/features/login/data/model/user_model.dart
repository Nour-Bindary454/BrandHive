class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;

  UserModel({this.id, this.name, this.email, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}
