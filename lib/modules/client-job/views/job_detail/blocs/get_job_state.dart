part of 'get_job_bloc.dart';

abstract class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailLoaded extends JobDetailState {
  final JobDetailEntity job;

  const JobDetailLoaded({required this.job});
}

class ErrorLoadingJobDetail extends JobDetailState {
  final String message;

  const ErrorLoadingJobDetail({required this.message});
}

class ChangeJobProgressLoading extends JobDetailState {}

class ChangeJobProgressLoaded extends JobDetailState {
  final JobIdEntity jobId;

  const ChangeJobProgressLoaded({required this.jobId});
}

class ErrorLoadingChangeJobProgress extends JobDetailState {
  final String message;

  const ErrorLoadingChangeJobProgress({required this.message});
}

class MilestoneInitial extends JobDetailState {}

class MilestoneLoading extends JobDetailState {}

class MilestoneLoaded extends JobDetailState {
  final PaginatedQueryResult<List<MilestoneEntity>> milestones;

  const MilestoneLoaded({required this.milestones});

  @override
  List<Object> get props => [milestones];
}

class ErrorLoadingMilestones extends JobDetailState {
  final String message;

  const ErrorLoadingMilestones({required this.message});

  @override
  List<Object> get props => [message];
}


class PayFreelancerLoading extends JobDetailState {}

class PayFreelancerLoaded extends JobDetailState {
  final JobIdEntity jobId;

  const PayFreelancerLoaded({required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class ErrorLoadingPayFreelancer extends JobDetailState {
  final String message;

  const ErrorLoadingPayFreelancer({required this.message});

  @override
  List<Object> get props => [message];
}

class AddMilestoneLoading extends JobDetailState {}

class AddMilestoneLoaded extends JobDetailState {}

class ErrorLoadingAddMilestone extends JobDetailState {
  final String message;

  const ErrorLoadingAddMilestone({required this.message});
}