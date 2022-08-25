part of 'post_job_bloc.dart';

abstract class JobPostState extends Equatable {
  const JobPostState();

  @override
  List<Object> get props => [];
}

class JobPostInitial extends JobPostState {}

class JobPostLoading extends JobPostState {}

class JobPostLoaded extends JobPostState {
  final JobDetailEntity job;
  
  const JobPostLoaded({required this.job});
}

class ErrorLoadingJobPost extends JobPostState {
  final String message;

  const ErrorLoadingJobPost({required this.message});
}
