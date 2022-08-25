import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FeedbackUsecase implements UseCase<String, FeedbackParams> {
  final SettingRepository settingRepository;

  FeedbackUsecase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(FeedbackParams params) async {
    return await settingRepository.feedback(
        firstName: params.firstName,
        lastName: params.lastName,
        message: params.message,
        title: params.title);
  }
}

class FeedbackParams extends Equatable {
  final String firstName;
  final String lastName;
  final String message;
  final String title;

  const FeedbackParams(this.firstName, this.lastName, this.message, this.title);

  @override
  List<Object?> get props => [firstName, lastName, message, title];
}
