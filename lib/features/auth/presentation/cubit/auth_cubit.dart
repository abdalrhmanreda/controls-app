import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:control_app/features/auth/data/models/login_request_model.dart';
import 'package:control_app/features/auth/data/repo/auth_repo.dart';
import 'package:control_app/core/cache/secure_storage_helper.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  // Check shared keychain for an existing token
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token != null && token.isNotEmpty) {
        final profileResponse = await _authRepository.getProfile(token);
        if (profileResponse.user != null) {
          emit(ProfileCheckSuccess(profileResponse.user!, token));
        } else {
          await SecureStorageHelper.clearAll();
          emit(ProfileCheckFailure(errorMessage: 'Invalid session'));
        }
      } else {
        emit(ProfileCheckFailure());
      }
    } catch (e) {
      // If profile fetch fails, it might be an expired token or network error.
      // If it's a 401/403 or similar validation error, we clear and show login.
      // For general errors, we emit failure but keep the token for manual retry.
      final errStr = e.toString();
      if (errStr.contains('401') || errStr.contains('403') || errStr.contains('Unauthorized')) {
        await SecureStorageHelper.clearAll();
        emit(ProfileCheckFailure(errorMessage: 'Session expired'));
      } else {
        emit(ProfileCheckFailure(errorMessage: 'Network error. Please try again.'));
      }
    }
  }

  // Handle standard email/password login in the Control App
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await _authRepository.login(request);
      if (response.access != null && response.user != null) {
        await SecureStorageHelper.saveAccessToken(response.access!);
        if (response.refresh != null) {
          await SecureStorageHelper.saveRefreshToken(response.refresh!);
        }
        emit(AuthSuccess(response.user!));
      } else {
        emit(AuthError(response.message ?? 'Authentication failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Log out and clear keys from the shared secure keychain
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await SecureStorageHelper.clearAll();
      emit(ProfileCheckFailure());
    } catch (e) {
      emit(AuthError('Logout failed: $e'));
    }
  }
}
