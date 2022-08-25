import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/data/data_sources/remote_data_source.dart';
import 'package:clean_flutter/modules/settings/data/repositories/setting_repository_impl.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/delete_account.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/feedback.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/password/change_password.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/reset_password.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_address.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_basic_info.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_description.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_overview.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_social_links.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/upload_profile_picture.dart';
import 'package:get_it/get_it.dart';

void injectSetting(GetIt container) {
  //! Data source injection
  container.registerLazySingleton<SettingRemoteDataSource>(
      () => SettingRemoteDataSourceImpl(dio: container()));

  //! Repository injection
  container.registerLazySingleton<SettingRepository>(
      () => SettingRepositoryImpl(settingRemoteDataSource: container()));

  // UseCase injection
  container.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(settingRepository: container()));
  container.registerLazySingleton(
      () => UploadProfilePictureUseCase(settingRepository: container()));
  container.registerLazySingleton(
      () => UpdateBasicInfoUseCase(settingRepository: container()));
  container.registerLazySingleton(
      () => UpdateAddressUsecase(settingRepository: container()));
  container.registerLazySingleton(
      () => UpdateDescriptionUsecase(settingRepository: container()));

  container.registerLazySingleton(
      () => UpdateOverviewUseCase(settingRepository: container()));
  container.registerLazySingleton(
      () => UpdateSocialLinksUseCase(settingRepository: container()));
  container.registerLazySingleton(
      () => DeleteAccountUseCase(repository: container()));
  container.registerLazySingleton(
      () => FeedbackUsecase(settingRepository: container()));
  container.registerLazySingleton(
      () => ResetPasswordUseCase(settingRepository: container()));

  container.registerFactory(() => SettingBloc(
      changePassword: container(),
      uploadProfilePictureUseCase: container(),
      updateBasicInfoUseCase: container(),
      updateAddressUsecase: container(),
      updateDescriptionUsecase: container(),
      updateOverviewUseCase: container(),
      updateSocialLinksUseCase: container(),
      deleteAccountUseCase: container(),
      feedbackUsecase: container(),
      resetPasswordUseCase: container()));
}
