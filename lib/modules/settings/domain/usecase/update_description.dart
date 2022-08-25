import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateDescriptionUsecase
    implements UseCase<String, UpdateDescriptionParams> {
  final SettingRepository settingRepository;

  UpdateDescriptionUsecase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(params) async {
    return await settingRepository.updateDescription(
        description: params.description);
  }
}

class UpdateDescriptionParams extends Equatable {
  final String description;

  const UpdateDescriptionParams({required this.description});

  @override
  List<Object?> get props => [description];
}
