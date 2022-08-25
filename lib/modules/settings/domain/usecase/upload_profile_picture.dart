import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UploadProfilePictureUseCase
    implements UseCase<String, UploadProfilePictureParams> {
  final SettingRepository settingRepository;

  UploadProfilePictureUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(
      UploadProfilePictureParams params) async {
    return await settingRepository.uploadProfilePicture(file: params.file);
  }
}

class UploadProfilePictureParams extends Equatable {
  // ignore: prefer_typing_uninitialized_variables
  final file;
  const UploadProfilePictureParams(this.file);

  @override
  List<Object?> get props => [file];
}
