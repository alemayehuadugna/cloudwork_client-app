import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateOverviewUseCase implements UseCase<String, UpdateOverviewParams> {
  final SettingRepository settingRepository;

  UpdateOverviewUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(UpdateOverviewParams params) async {
    return await settingRepository.updateOverview(
        companyName: params.companyName, websiteUrl: params.websiteUrl);
  }
}

class UpdateOverviewParams extends Equatable {
  final String companyName;
  final String websiteUrl;

  const UpdateOverviewParams(
      {required this.companyName, required this.websiteUrl});

  @override
  List<Object?> get props => [companyName, websiteUrl];
}
