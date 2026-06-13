import 'package:control_app/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class ProfileCheckSuccess extends AuthState {
  final UserModel user;
  final String token;
  ProfileCheckSuccess(this.user, this.token);
}

class ProfileCheckFailure extends AuthState {
  final String? errorMessage;
  ProfileCheckFailure({this.errorMessage});
}
