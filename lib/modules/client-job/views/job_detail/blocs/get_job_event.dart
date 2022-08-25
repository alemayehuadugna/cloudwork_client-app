part of 'get_job_bloc.dart';

abstract class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override
  List<Object> get props => [];
}

class GetJobEvent extends JobDetailEvent {
  final String id;

  const GetJobEvent({required this.id});
}

class GetJobProgressEvent extends JobDetailEvent {
  final String id;
  final String progress;
  final String freelancerId;
  final String clientId;

  const GetJobProgressEvent({
    required this.id,
    required this.progress,
    required this.freelancerId,
    required this.clientId,
  });
}

class ListMilestonesEvent extends JobDetailEvent {
  final dynamic pagination;
  final dynamic filter;
  final dynamic sort;
  final String jobId;
  final String type;

  const ListMilestonesEvent(
      {required this.pagination,
      this.filter,
      this.sort,
      required this.jobId,
      required this.type});
  @override
  List<Object> get props => [];
}

class PayFreelancerEvent extends JobDetailEvent {
  final String milestoneId;
  final String jobId;
  final String? freelancerId;
  final String? clientId;
  final double amount;

  const PayFreelancerEvent(
      {required this.milestoneId,
      required this.jobId,
      required this.freelancerId,
      required this.clientId,
      required this.amount});
  @override
  List<Object> get props => [];
}

class AddMilestoneEvent extends JobDetailEvent {
  final AddMilestoneParams payload;

  const AddMilestoneEvent({required this.payload});
}
