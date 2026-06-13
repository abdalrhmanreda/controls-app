import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:control_app/features/auth/data/models/login_request_model.dart';
import 'package:control_app/features/auth/data/models/login_response_model.dart';
import 'package:control_app/features/auth/data/models/profile_response_model.dart';
import 'api_constant.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;

  @GET('/test')
  Future<String> testEndpoint();

  @POST(ApiConstant.loginEndpoint)
  Future<LoginResponseModel> login(
    @Body() LoginRequestModel body,
  );

  @GET(ApiConstant.profileEndpoint)
  Future<ProfileResponseModel> getProfile(
    @Header("Authorization") String token,
  );
}
