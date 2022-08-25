part of 'freelancer_detail_bloc.dart';

abstract class FreelancerDetailEvent extends Equatable {
  const FreelancerDetailEvent();

  @override
  List<Object> get props => [];
}

class GetFreelancerDetailEvent extends FreelancerDetailEvent {
  final String id;

  const GetFreelancerDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
