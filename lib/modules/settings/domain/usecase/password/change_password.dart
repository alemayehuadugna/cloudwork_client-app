import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final SettingRepository settingRepository;

  ChangePasswordUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) async {
    return await settingRepository.changePassword(
        oldPassword: params.oldPassword, newPassword: params.newPassword);
  }
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordParams(
      {required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
