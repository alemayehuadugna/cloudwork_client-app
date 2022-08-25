import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/job.dart';

class HireFreelancerUseCase implements UseCase<JobIdEntity, HireParams> {
  final JobRepository repository;

  HireFreelancerUseCase({required this.repository});

  @override
  Future<Either<Failure, JobIdEntity>> call(HireParams params) async {
    return await repository.hireFreelancer(params);
  }
}

class HireParams extends Equatable {
  final String id;
  final String freelancerId;
  final String clientId;
  final double amount;

  const HireParams({required this.id, required this.freelancerId, required this.clientId, required this.amount});

  @override
  List<Object?> get props => [id, freelancerId];
}
