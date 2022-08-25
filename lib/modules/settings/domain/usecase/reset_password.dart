import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordUseCase implements UseCase<String, ResetPasswordParams> {
  final SettingRepository settingRepository;

  ResetPasswordUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) async {
    return await settingRepository.resetPassword(
        email: params.email, password: params.password);
  }
}

class ResetPasswordParams extends Equatable {
  final String email;
  final String password;

  const ResetPasswordParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
