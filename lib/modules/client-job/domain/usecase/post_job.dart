import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';

class PostJobUseCase implements UseCase<JobDetailEntity, JobDetailEntity> {
  final JobRepository repository;

  PostJobUseCase({required this.repository});

  @override
  Future<Either<Failure, JobDetailEntity>> call(JobDetailEntity params) async {
    return await repository.postJob(params);
  }
}
