import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateBasicInfoUseCase implements UseCase<String, UpdateBasicInfoParams> {
  final SettingRepository settingRepository;

  UpdateBasicInfoUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(UpdateBasicInfoParams params) async {
    return await settingRepository.updateBasicProfile(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        phone: params.phone);
  }
}

class UpdateBasicInfoParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const UpdateBasicInfoParams(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone});

  @override
  List<Object?> get props => [firstName, lastName, email, phone];
}
