import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class VerifyEmailUseCase implements UseCase<void, VerifyEmailParams> {
  final UserRepository repository;

  VerifyEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(VerifyEmailParams params) async {
    return repository.verifyEmail(code: params.code, email: params.email);
  }
}

class VerifyEmailParams extends Equatable {
  final String code;
  final String email;

  const VerifyEmailParams(this.code, this.email);

  @override
  List<Object?> get props => [code, email];
}
