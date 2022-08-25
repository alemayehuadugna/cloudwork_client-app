import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailUserUsecase implements UseCase<DetailUser, NoParams> {
  final UserRepository repository;

  GetDetailUserUsecase({required this.repository});

  @override
  Future<Either<Failure, DetailUser>> call(NoParams params) async {
    return await repository.getDetailUSer();
  }
}
