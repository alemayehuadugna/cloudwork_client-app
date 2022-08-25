import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/_shared/domain/usecase/list_categories.dart';
import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../usecase/addMilestone.dart';
import '../usecase/changeProgress.dart';
import '../usecase/deleteJob.dart';
import '../usecase/hire_freelancer.dart';
import '../usecase/payFreelancer.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> listJobs(PaginationParams params);
  Future<Either<Failure, JobDetailEntity>> getJob(JobParams params);
  Future<Either<Failure, List<JobEntity>>> pendingJobs(PaginationParams params);
  Future<Either<Failure, List<JobEntity>>> ongoingJobs(PaginationParams params);
  Future<Either<Failure, List<JobEntity>>> completedJobs(
      PaginationParams params);
  Future<Either<Failure, List<JobEntity>>> cancelJobs(PaginationParams params);
  Future<Either<Failure, JobDetailEntity>> editJob(JobDetailEntity params);
  Future<Either<Failure, JobProposalEntity>> viewProposals(JobParams params);
  Future<Either<Failure, JobDetailEntity>> postJob(JobDetailEntity params);
  Future<Either<Failure, JobIdEntity>> changeProgressJob(ProgressParams params);
  Future<Either<Failure, JobIdEntity>> hireFreelancer(HireParams params);
  Future<Either<Failure, PaginatedQueryResult<List<MilestoneEntity>>>>
      listMilestones({pagination, filter, sort, jobId, type});
  Future<Either<Failure, JobIdEntity>> payFreelancer(PaymentParams params);
  Future<Either<Failure, String>> deleteJob(DeleteJobParams params);
  Future<Either<Failure, String>> addMilestone(AddMilestoneParams params);
}
