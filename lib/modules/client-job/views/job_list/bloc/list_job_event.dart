part of 'list_job_bloc.dart';


abstract class ListJobEvent extends Equatable {
  const ListJobEvent();

  @override
  List<Object> get props => [];
}

class ListJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String clientId;

  const ListJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.clientId
  });
}

class ListPendingJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String clientId;

  const ListPendingJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.clientId
  });
}

class ListOngoingJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String clientId;

  const ListOngoingJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.clientId
  });
}

class ListCompletedJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String clientId;

  const ListCompletedJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.clientId
  });
}

class ListCanceledJobInSubmitted extends ListJobEvent {
  final int pageSize;
  final int pageKey; 
  final String clientId;

  const ListCanceledJobInSubmitted({
    required this.pageSize, 
    required this.pageKey, 
    required this.clientId
  });
}

class DeleteJobEvent extends ListJobEvent {
  final String id;
  final String freelancerId; 
  final String clientId;

  const DeleteJobEvent({required this.id, required this.freelancerId, required this.clientId });
}