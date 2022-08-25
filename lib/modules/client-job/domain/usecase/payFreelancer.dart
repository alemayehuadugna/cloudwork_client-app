import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/job.dart';

class PayFreelancerUseCase implements UseCase<JobIdEntity, PaymentParams> {
  final JobRepository repository;

  PayFreelancerUseCase({required this.repository});

  @override
  Future<Either<Failure, JobIdEntity>> call(PaymentParams params) async {
    return await repository.payFreelancer(params);
  }
}

class PaymentParams extends Equatable {
  final String milestoneId;
  final String jobId;
  final String? freelancerId;
  final String? clientId;
  final double amount;


  const PaymentParams({required this.milestoneId, required this.jobId, required this.freelancerId, required this.clientId, required this.amount});

  @override
  List<Object?> get props => [milestoneId, jobId, freelancerId, clientId, amount];
}
