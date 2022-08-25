import '../chat/domain/usecases/stop_socket_service.dart';
import 'domain/usecase/email/verify_forget_email.dart';
import 'views/verify_email/cubit/useremail_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../_shared/interface/bloc/setting/desktop_nav_cubit.dart';
import '../../_shared/interface/bloc/setting/theme_mode_cubit.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repo/user_repository.dart';
import 'domain/usecase/email/resend_otp.dart';
import 'domain/usecase/email/verify_email.dart';
import 'domain/usecase/index.dart';
import 'domain/usecase/register.dart';
import 'views/profile/bloc/profile_bloc.dart';
import 'views/sign_in/bloc/login_bloc.dart';
import 'views/sign_up/bloc/register_bloc.dart';
import 'views/verify_email/bloc/verify_email_bloc.dart';

void injectUsers(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(hive: container()));
  container.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );

  //! Use Case Injection
  container.registerLazySingleton(
      () => GetAuthStatusUseCase(repository: container()));
  container.registerLazySingleton(
      () => GetBasicUserUsecase(repository: container()));
  container.registerLazySingleton(
    () => SignInUseCase(repository: container()),
  );
  container.registerLazySingleton(
    () => SignOutUseCase(repository: container()),
  );
  container.registerLazySingleton(
    () => RegisterUseCase(repository: container()),
  );

  container.registerLazySingleton(
    () => VerifyEmailUseCase(repository: container()),
  );

  container.registerLazySingleton(
      () => VerifyForgetEmailUsecase(repository: container()));

  container.registerLazySingleton(
    () => ResendOTPUseCase(repository: container()),
  );
  container.registerLazySingleton(
      () => GetDetailUserUsecase(repository: container()));
  container
      .registerLazySingleton(() => StopSocketService(repository: container()));

  //! Bloc Injection
  container.registerLazySingleton(() => AuthBloc(
        authStatus: container(),
        getUser: container(),
        // signIn: container(),
        signOut: container(),
        startChatUseCase: container(),
        stopSocketService: container(),
        startAlertService: container(),
      )..add(AppLoaded()));
  container.registerLazySingleton(() => DesktopSideNavCubit());
  container.registerLazySingleton(() => ThemeModeCubit());
  container.registerFactory(() => LoginBloc(
        authBloc: container(),
        signIn: container(),
        getUser: container(),
      ));
  container.registerFactory(() => ProfileBloc(
        getDetailUser: container(),
      ));

  container.registerFactory(
    () => RegisterBloc(
      loginBloc: container(),
      registerUseCase: container(),
    ),
  );

  container.registerFactory(() => VerifyEmailBloc(
      authBloc: container(),
      getBasicUserUsecase: container(),
      verifyEmailUseCase: container(),
      resendOTPUseCase: container(),
      verifyForgetEmailUsecase: container()));
  container.registerFactory(() => UseremailCubit());
}
