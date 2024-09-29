class AuthModel {
  final String email;
  final String userName;
  final String password;

  AuthModel({
    required this.email,
    required this.userName,
    required this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        email: json['email'] ?? '',
        userName: json['username'] ?? '',
        password: json['password'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'username': userName, 'email': email, 'password': password};
  }
}
