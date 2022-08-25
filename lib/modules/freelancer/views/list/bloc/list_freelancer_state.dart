part of 'list_freelancer_bloc.dart';

abstract class ListFreelancerState extends Equatable {
  const ListFreelancerState();

  @override
  List<Object> get props => [];
}

class ListFreelancerInitial extends ListFreelancerState {}

class ListFreelancerLoading extends ListFreelancerState {}

class ListFreelancerLoaded extends ListFreelancerState {
  final List<FreelancerBasic> freelancerList;
  final ResultPage page;

  const ListFreelancerLoaded(this.freelancerList, this.page);

  @override
  List<Object> get props => [freelancerList];
}

class ListFreelancerError extends ListFreelancerState {
  final String message;

  const ListFreelancerError(this.message);

  @override
  List<Object> get props => [message];
}
