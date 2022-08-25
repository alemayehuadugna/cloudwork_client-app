import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';

class AddMilestoneUseCase implements UseCase<String, AddMilestoneParams> {
  final JobRepository repository;

  AddMilestoneUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddMilestoneParams params) async {
    return await repository.addMilestone(params);
  }
}

class AddMilestoneParams extends Equatable {
  final String jobId;
  final String name;
  final double budget;
  final String startDate;
  final String endDate;
  final String description;

  AddMilestoneParams(this.jobId, this.name, this.budget, this.startDate, this.endDate,
      this.description);

  @override
  List<Object?> get props =>
      [jobId, name, budget, startDate, endDate, description];
}