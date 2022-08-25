part of 'list_job_bloc.dart';

abstract class ListJobState extends Equatable {
  const ListJobState();

  @override
  List<Object> get props => [];
}

class ListJobInitial extends ListJobState {}

class ListJobLoading extends ListJobState {}

class ListJobLoaded extends ListJobState {
  final List<JobEntity> job;

  const ListJobLoaded({required this.job});
}

class ErrorLoadingListJob extends ListJobState {
  final String message;

  const ErrorLoadingListJob({required this.message});
}

class ListPendingJobLoading extends ListJobState {}

class ListPendingJobLoaded extends ListJobState {
  final List<JobEntity> pendingJob;

  const ListPendingJobLoaded({required this.pendingJob});
}

class ErrorLoadingListPendingJob extends ListJobState {
  final String message;

  const ErrorLoadingListPendingJob({required this.message});
}

class ListOngoingJobLoading extends ListJobState {}

class ListOngoingJobLoaded extends ListJobState {
  final List<JobEntity> ongoingJob;

  const ListOngoingJobLoaded({required this.ongoingJob});
}

class ErrorLoadingListOngoingJob extends ListJobState {
  final String message;

  const ErrorLoadingListOngoingJob({required this.message});
}

class ListCompletedJobLoading extends ListJobState {}

class ListCompletedJobLoaded extends ListJobState {
  final List<JobEntity> completedJob;

  const ListCompletedJobLoaded({required this.completedJob});
}

class ErrorLoadingListCompletedJob extends ListJobState {
  final String message;

  const ErrorLoadingListCompletedJob({required this.message});
}

class ListCanceledJobLoading extends ListJobState {}

class ListCanceledJobLoaded extends ListJobState {
  final List<JobEntity> canceledJob;

  const ListCanceledJobLoaded({required this.canceledJob});
}

class ErrorLoadingListCanceledJob extends ListJobState {
  final String message;

  const ErrorLoadingListCanceledJob({required this.message});
}

class DeleteJobLoading extends ListJobState {}

class DeleteJobLoaded extends ListJobState {}

class ErrorLoadingDeleteJob extends ListJobState {
  final String message;

  const ErrorLoadingDeleteJob({required this.message});
}
