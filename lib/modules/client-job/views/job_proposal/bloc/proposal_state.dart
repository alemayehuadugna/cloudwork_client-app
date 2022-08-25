part of 'proposal_bloc.dart';

abstract class ProposalsState extends Equatable {
  const ProposalsState();

  @override
  List<Object> get props => [];
}

class ProposalsInitial extends ProposalsState {}

class ProposalsLoading extends ProposalsState {}

class ProposalsLoaded extends ProposalsState {
  final JobProposalEntity job;

  const ProposalsLoaded({required this.job});
}

class ErrorLoadingProposals extends ProposalsState {
  final String message;

  const ErrorLoadingProposals({required this.message});
}


class HireFreelancerLoading extends ProposalsState {}

class HireFreelancerLoaded extends ProposalsState {
  final String id;

  const HireFreelancerLoaded({required this.id});
}

class ErrorLoadingHireFreelancer extends ProposalsState {
  final String message;

  const ErrorLoadingHireFreelancer({required this.message});
}

