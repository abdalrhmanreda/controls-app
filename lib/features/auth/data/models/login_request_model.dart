class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        email: json['email'] as String,
        password: json['password'] as String,
      );
}
