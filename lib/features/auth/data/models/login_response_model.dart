import 'user_model.dart';

class LoginResponseModel {
  final UserModel? user;
  final String? refresh;
  final String? access;
  final String? message;

  LoginResponseModel({
    this.user,
    this.refresh,
    this.access,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return LoginResponseModel(
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      refresh: data['refresh'] as String?,
      access: data['access'] as String?,
      message: json['message'] as String? ?? data['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'refresh': refresh,
        'access': access,
        'message': message,
      };
}
