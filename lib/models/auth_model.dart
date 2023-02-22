class AuthModel {
  String? login;
  String? password;

  AuthModel({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['password'] = password;
    return data;
  }
}
