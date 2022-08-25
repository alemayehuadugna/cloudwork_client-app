part of 'proposal_bloc.dart';

abstract class ProposalsEvent extends Equatable {
  const ProposalsEvent();

  @override 
  List<Object> get props => []; 
}


class ViewProposalsEvent extends ProposalsEvent {
  final String id;

  const ViewProposalsEvent({required this.id});
}

class HireFreelancerEvent extends ProposalsEvent {
  final String id;
  final String freelancerId;
  final String? clientId; 
  final double amount;

  const HireFreelancerEvent({required this.id, required this.freelancerId, required this.clientId, required this.amount});
}