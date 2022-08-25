import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetBasicUserUsecase implements UseCase<BasicUser, NoParams> {
  final UserRepository repository;

  GetBasicUserUsecase({required this.repository});

  @override
  Future<Either<Failure, BasicUser>> call(NoParams params) async {
    return await repository.getCurrentBasicUser();
  }
}
