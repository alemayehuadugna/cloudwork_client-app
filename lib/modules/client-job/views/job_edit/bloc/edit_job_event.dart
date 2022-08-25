part of 'edit_job_bloc.dart';

abstract class JobEditEvent extends Equatable {
  const JobEditEvent();

  @override
  List<Object> get props => [];
}

class GetJobForEditEvent extends JobEditEvent {
  final String id;

  const GetJobForEditEvent({required this.id});
}

class EditJobEvent extends JobEditEvent {
  final JobDetailEntity payload;

  const EditJobEvent({required this.payload});
}
