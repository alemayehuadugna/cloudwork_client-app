import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../../common/params.dart';
import '../repo/job_repository.dart';

class DeleteJobUseCase
    implements UseCase<String, DeleteJobParams> {
  final JobRepository repository;

  DeleteJobUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(DeleteJobParams params) async {
    return await repository.deleteJob(params);
  }
}

class DeleteJobParams extends Equatable {
  final String id;
  final String freelancerId; 
  final String clientId;

  const DeleteJobParams({required this.id, required this.freelancerId, required this.clientId});

  @override 
  List<Object?> get props => [id, freelancerId, clientId];
}
