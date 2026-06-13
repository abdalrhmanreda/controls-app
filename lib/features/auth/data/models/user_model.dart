import 'car_model.dart';

class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? role;
  final bool? isActive;
  final String? profilePicture;
  final List<CarModel>? cars;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.role,
    this.isActive,
    this.profilePicture,
    this.cars,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String,
      role: json['role'] as String?,
      isActive: json['is_active'] as bool?,
      profilePicture: json['profile_picture'] as String?,
      cars: json['cars'] != null
          ? (json['cars'] as List).map((i) => CarModel.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'role': role,
        'is_active': isActive,
        'profile_picture': profilePicture,
        'cars': cars?.map((i) => i.toJson()).toList(),
      };
}
