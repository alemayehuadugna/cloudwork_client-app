import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class VerifyForgetEmailUsecase
    implements UseCase<void, VerifyForgetEmailParams> {
  final UserRepository repository;

  VerifyForgetEmailUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(VerifyForgetEmailParams params) async {
    return repository.verifyForgetEmail(code: params.code, email: params.email);
  }
}

class VerifyForgetEmailParams extends Equatable {
  final String code;
  final String email;

  const VerifyForgetEmailParams(this.code, this.email);

  @override
  List<Object?> get props => [code, email];
}
