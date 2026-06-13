import 'package:dio/dio.dart';
import 'package:control_app/core/api/api_services.dart';
import 'package:control_app/core/api/dio_factory.dart';
import 'package:control_app/features/auth/data/repo/auth_repo.dart';
import 'package:control_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  try {
    print('Starting setupGetIt...');

    // Dio & ApiServices
    if (!getIt.isRegistered<Dio>()) {
      Dio dio = await DioFactory.initDio();
      getIt.registerLazySingleton<Dio>(() => dio);
    }
    if (!getIt.isRegistered<ApiServices>()) {
      getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt<Dio>()));
    }

    // Register your feature repositories and cubits here below:
    if (!getIt.isRegistered<AuthRepository>()) {
      getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepository(getIt<ApiServices>()),
      );
    }
    if (!getIt.isRegistered<AuthCubit>()) {
      getIt.registerFactory<AuthCubit>(
        () => AuthCubit(getIt<AuthRepository>()),
      );
    }
  } catch (e) {
    print('Error in setupGetIt: $e');
  }
}
