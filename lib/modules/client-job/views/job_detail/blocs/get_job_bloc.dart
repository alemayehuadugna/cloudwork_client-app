import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/get_job.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/cqrs.dart';
import '../../../../../_core/error/failures.dart';
import '../../../domain/usecase/addMilestone.dart';
import '../../../domain/usecase/changeProgress.dart';
import '../../../domain/usecase/list_milestones.dart';
import '../../../domain/usecase/payFreelancer.dart';

part 'get_job_event.dart';
part 'get_job_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final GetJobUseCase _getJob;
  final ChangeJobProgressJobUseCase _changeProgress;
  final ListMilestonesUseCase _listMilestonesUsecase;
  final PayFreelancerUseCase _payFreelancerUsecase;
  final AddMilestoneUseCase _addMilestone;

  JobDetailBloc({
    required GetJobUseCase getJob,
    required ChangeJobProgressJobUseCase changeProgress,
    required ListMilestonesUseCase listMilestones,
    required PayFreelancerUseCase payFreelancer,
    required AddMilestoneUseCase addMilestone,
  })  : _getJob = getJob,
        _changeProgress = changeProgress,
        _listMilestonesUsecase = listMilestones,
        _payFreelancerUsecase = payFreelancer,
        _addMilestone = addMilestone,
        super(JobDetailInitial()) {
    on<GetJobEvent>(_getJobDetail);
    on<GetJobProgressEvent>(_changeJobProgress);
    on<ListMilestonesEvent>(_listMilestonesEvent);
    on<PayFreelancerEvent>(_payFreelancerEvent);
    on<AddMilestoneEvent>(_addMilestoneEvent);
  }

  void _getJobDetail(GetJobEvent event, Emitter<JobDetailState> emit) async {
    emit(JobDetailLoading());
    final result = await _getJob(JobParams(id: event.id));
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingJobDetail(message: error.message);
        }
        return const ErrorLoadingJobDetail(message: 'Unknown Error');
      }, (job) => JobDetailLoaded(job: job)),
    );
  }

  void _changeJobProgress(
      GetJobProgressEvent event, Emitter<JobDetailState> emit) async {
    emit(ChangeJobProgressLoading());
    final result = await _changeProgress(
        ProgressParams(id: event.id, progress: event.progress, freelancerId: event.freelancerId, clientId: event.clientId));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingChangeJobProgress(message: error.message);
        }
        return const ErrorLoadingChangeJobProgress(
            message: 'Error Loading Milestones');
      },
      (jobId) {
        return ChangeJobProgressLoaded(jobId: jobId);
      },
    ));
  }

  void _listMilestonesEvent(
      ListMilestonesEvent event, Emitter<JobDetailState> emit) async {
    emit(MilestoneLoading());
    final result = await _listMilestonesUsecase(MilestoneParams(
        query: QueryParams(event.pagination, event.filter, event.sort),
        jobId: event.jobId,
        type: event.type));

    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingMilestones(message: error.message);
        }
        return const ErrorLoadingMilestones(
            message: 'Error Loading Milestones');
      },
      (milestones) {
        return MilestoneLoaded(milestones: milestones);
      },
    ));
  }

  void _payFreelancerEvent(
      PayFreelancerEvent event, Emitter<JobDetailState> emit) async {
    emit(PayFreelancerLoading());
    final result = await _payFreelancerUsecase(PaymentParams(
        milestoneId: event.milestoneId,
        jobId: event.jobId,
        freelancerId: event.freelancerId,
        clientId: event.clientId,
        amount: event.amount));

    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingMilestones(message: error.message);
        }
        return const ErrorLoadingMilestones(
            message: 'Error Loading Pay Freelancer');
      },
      (jobId) {
        return PayFreelancerLoaded(jobId: jobId);
      },
    ));
  }

  void _addMilestoneEvent(
      AddMilestoneEvent event, Emitter<JobDetailState> emit) async {
    emit(AddMilestoneLoading());
    final result = await _addMilestone(
      AddMilestoneParams(
        event.payload.jobId,
        event.payload.name,
        event.payload.budget,
        event.payload.startDate,
        event.payload.endDate,
        event.payload.description
      ),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingAddMilestone(message: error.message);
        }
        return const ErrorLoadingAddMilestone(message: 'Error While Deleting Job');
      },
      (result) {
        return AddMilestoneLoaded();
      },
    ));
  }
}
