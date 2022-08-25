import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/hire_freelancer.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/view_job_proposals.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';

part 'proposal_event.dart';
part 'proposal_state.dart';

class ProposalsBloc extends Bloc<ProposalsEvent, ProposalsState> {
  final ProposalUseCase _viewProposals;
  final HireFreelancerUseCase _hireFreelancer;

  ProposalsBloc(
      {required ProposalUseCase viewProposals,
      required HireFreelancerUseCase hireFreelancer})
      : _viewProposals = viewProposals,
        _hireFreelancer = hireFreelancer,
        super(ProposalsInitial()) {
    on<ViewProposalsEvent>(_viewProposalsDetail);
    on<HireFreelancerEvent>(_hireFreelancerMethod);
  }

  void _viewProposalsDetail(
      ViewProposalsEvent event, Emitter<ProposalsState> emit) async {
    emit(ProposalsLoading());
    final result = await _viewProposals(JobParams(id: event.id));
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingProposals(message: error.message);
        }
        return const ErrorLoadingProposals(message: 'Unknown Error');
      }, (job) => ProposalsLoaded(job: job)),
    );
  }

  void _hireFreelancerMethod(
      HireFreelancerEvent event, Emitter<ProposalsState> emit) async {
    emit(HireFreelancerLoading());
    final result = await _hireFreelancer(
        HireParams(id: event.id, freelancerId: event.freelancerId, clientId: event.clientId!, amount: event.amount));
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingHireFreelancer(message: error.message);
        }
        return const ErrorLoadingHireFreelancer(message: 'Unknown Error');
      }, (id) => HireFreelancerLoaded(id: id.id)),
    );
  }
}
