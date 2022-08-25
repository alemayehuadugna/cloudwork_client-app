part of 'list_freelancer_bloc.dart';

abstract class ListFreelancerEvent extends Equatable {
  const ListFreelancerEvent();

  @override
  List<Object> get props => [];
}

class LoadFreelancersEvent extends ListFreelancerEvent {
  final dynamic pagination;
  final dynamic filter;
  final dynamic sort;

  const LoadFreelancersEvent(this.pagination, this.filter, this.sort);

  @override
  List<Object> get props => [pagination, filter, sort];
}
