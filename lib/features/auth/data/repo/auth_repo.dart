import 'package:control_app/core/api/api_services.dart';
import 'package:control_app/features/auth/data/models/login_request_model.dart';
import 'package:control_app/features/auth/data/models/login_response_model.dart';
import 'package:control_app/features/auth/data/models/profile_response_model.dart';

class AuthRepository {
  final ApiServices _apiServices;

  AuthRepository(this._apiServices);

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await _apiServices.login(request);
  }

  Future<ProfileResponseModel> getProfile(String token) async {
    return await _apiServices.getProfile('Bearer $token');
  }
}
