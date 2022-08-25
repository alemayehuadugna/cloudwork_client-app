import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResendOTPUseCase implements UseCase<void, ResendOTPParams> {
  final UserRepository repository;

  ResendOTPUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.resendOTP(email: params.email, type: params.type);
  }
}

class ResendOTPParams extends Equatable {
  final String email;
  final String type;

  const ResendOTPParams(this.email, this.type);

  @override
  List<Object?> get props => [email, type];
}
