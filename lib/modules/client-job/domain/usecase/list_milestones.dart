import 'package:clean_flutter/_core/cqrs.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/job.dart';
import '../repo/job_repository.dart';

class ListMilestonesUseCase
    implements
        UseCase<PaginatedQueryResult<List<MilestoneEntity>>, MilestoneParams> {
  final JobRepository repository;

  ListMilestonesUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedQueryResult<List<MilestoneEntity>>>> call(
      MilestoneParams params) async {
    return await repository.listMilestones(
        type: params.type, 
        jobId: params.jobId,
        pagination: params.query.pagination,
        sort: params.query.sort,
        filter: params.query.filter, 
      );
  }
}

class MilestoneParams extends Equatable {
  final String jobId;
  final String type;
  final QueryParams query;


  const MilestoneParams({required this.query, required this.jobId, required this.type});

  @override
  List<Object?> get props => [jobId, query, type];
}