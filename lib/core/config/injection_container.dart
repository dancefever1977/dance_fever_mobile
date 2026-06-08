import 'package:dance_fever/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dance_fever/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:dance_fever/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:dance_fever/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/logout_usecase.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      checkAuthUserCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginWithGoogleUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(() => FirebaseAuthentication());
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDatasourceImpl(sharedPreferences: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
