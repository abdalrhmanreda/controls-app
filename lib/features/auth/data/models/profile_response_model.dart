import 'user_model.dart';

class ProfileResponseModel {
  final int? status;
  final String? message;
  final bool? authenticated;
  final UserModel? user;

  ProfileResponseModel({
    this.status,
    this.message,
    this.authenticated,
    this.user,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return ProfileResponseModel(
      status: json['status'] as int?,
      message: json['message'] as String? ?? data['message'] as String?,
      authenticated: data['authenticated'] as bool?,
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'authenticated': authenticated,
        'user': user?.toJson(),
      };
}
