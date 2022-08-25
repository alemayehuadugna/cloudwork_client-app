import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../../common/params.dart';
import '../entities/job.dart';

class ChangeJobProgressJobUseCase
    implements UseCase<JobIdEntity, ProgressParams> {
  final JobRepository repository;

  ChangeJobProgressJobUseCase({required this.repository});

  @override
  Future<Either<Failure, JobIdEntity>> call(ProgressParams params) async {
    return await repository.changeProgressJob(params);
  }
}

class ProgressParams extends Equatable {
  final String id;
  final String progress;
  final String freelancerId; 
  final String clientId;

  const ProgressParams({required this.progress, required this.id, required this.freelancerId, required this.clientId});

  @override
  List<Object?> get props => [progress, id];
}
