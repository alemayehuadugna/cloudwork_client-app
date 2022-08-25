part of 'edit_job_bloc.dart';

abstract class JobEditState extends Equatable {
  const JobEditState();

  @override
  List<Object> get props => [];
}

class JobDetailForEditInitial extends JobEditState {}

class JobDetailForEditLoading extends JobEditState {}

class JobDetailForEditLoaded extends JobEditState {
  final JobDetailEntity job;

  const JobDetailForEditLoaded({required this.job});
}

class ErrorLoadingJobDetailForEdit extends JobEditState {
  final String message;

  const ErrorLoadingJobDetailForEdit({required this.message});
}

class JobEditLoading extends JobEditState {}

class JobEditLoaded extends JobEditState {
  final JobDetailEntity job;

  const JobEditLoaded({required this.job});
}

class ErrorLoadingJobEdit extends JobEditState {
  final String message;

  const ErrorLoadingJobEdit({required this.message});
}
