part of 'post_job_bloc.dart'; 

abstract class JobPostEvent extends Equatable {
  const JobPostEvent();

  @override 
  List<Object> get props => []; 
}


class PostJobEvent extends JobPostEvent {
  final JobDetailEntity payload;

  const PostJobEvent({required this.payload});
}