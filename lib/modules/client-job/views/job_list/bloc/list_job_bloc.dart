import 'package:clean_flutter/modules/client-job/common/pagination.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/canceledJobs.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/list_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/ongoing_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/pending_job.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';
import '../../../common/params.dart';
import '../../../domain/usecase/completedJobs.dart';
import '../../../domain/usecase/deleteJob.dart';

part 'list_job_event.dart';
part 'list_job_state.dart';

class ListJobBloc extends Bloc<ListJobEvent, ListJobState> {
  final ListJob _listJob;
  final PendingJob _pendingJob;
  final OngoingJob _ongoingJob;
  final CompletedJob _completedJob;
  final CanceledJob _canceledJob;
  final DeleteJobUseCase _deleteJob;

  ListJobBloc({
    required ListJob listJob,
    required PendingJob pendingJob,
    required OngoingJob ongoingJob,
    required CompletedJob completedJob,
    required CanceledJob canceledJob,
    required DeleteJobUseCase deleteJob
  })  : _listJob = listJob,
        _pendingJob = pendingJob,
        _ongoingJob = ongoingJob,
        _completedJob = completedJob,
        _canceledJob = canceledJob,
        _deleteJob = deleteJob,
        super(ListJobInitial()) {
    on<ListJobInSubmitted>(_listJobInSubmitted);
    on<ListPendingJobInSubmitted>(_listPendingJobInSubmitted);
    on<ListOngoingJobInSubmitted>(_listOngoingJobInSubmitted);
    on<ListCompletedJobInSubmitted>(_listCompletedJobInSubmitted);
    on<ListCanceledJobInSubmitted>(_listCanceledJobInSubmitted);
    on<DeleteJobEvent>(_deleteJobEvent);
  }

  Future<void> _listJobInSubmitted(
      ListJobInSubmitted event, Emitter<ListJobState> emit) async {
    emit(ListJobLoading());
    final result =
        await _listJob(PaginationParams(event.pageKey, event.pageSize, event.clientId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.appendLastPage([]);
          if (pagingController.itemList != null) {
            pagingController.itemList!.clear();
          }
          return ErrorLoadingListJob(message: error.message);
        }
        return const ErrorLoadingListJob(message: 'Unknown Error');
      }, (job) => ListJobLoaded(job: job)),
    );
  }

  Future<void> _listPendingJobInSubmitted(
      ListPendingJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListPendingJobLoading) {
      emit(ListPendingJobLoading());
    }
    final result =
        await _pendingJob(PaginationParams(event.pageKey, event.pageSize, event.clientId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.itemList!.clear();

          return ErrorLoadingListPendingJob(message: error.message);
        }
        return const ErrorLoadingListPendingJob(message: 'Unknown Error');
      }, (pendingJob) => ListPendingJobLoaded(pendingJob: pendingJob)),
    );
  }

  Future<void> _listOngoingJobInSubmitted(
      ListOngoingJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListOngoingJobLoading) {
      emit(ListOngoingJobLoading());
    }
    final result =
        await _ongoingJob(PaginationParams(event.pageKey, event.pageSize, event.clientId));

    emit(
      // result.fold(
      //     (failure) => const ErrorLoadingListOngoingJob(
      //         message: "Error Loading Ongoing Job List"), (ongoingJob) {
      //   return ListOngoingJobLoaded(ongoingJob: ongoingJob);
      // }),

      result.fold((error) {
        if (error is ServerFailure) {
          print("ongoing error");
          pagingController.itemList!.clear();

          return ErrorLoadingListOngoingJob(message: error.message);
        }
        return const ErrorLoadingListOngoingJob(message: 'Unknown Error');
      }, (ongoingJob) => ListOngoingJobLoaded(ongoingJob: ongoingJob)),
    );
  }

  Future<void> _listCompletedJobInSubmitted(
      ListCompletedJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListCompletedJobLoading) {
      emit(ListCompletedJobLoading());
    }
    final result =
        await _completedJob(PaginationParams(event.pageKey, event.pageSize, event.clientId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.itemList!.clear();

          return ErrorLoadingListCompletedJob(message: error.message);
        }
        return const ErrorLoadingListCompletedJob(message: 'Unknown Error');
      }, (completedJob) => ListCompletedJobLoaded(completedJob: completedJob)),
    );
  }

  Future<void> _listCanceledJobInSubmitted(
      ListCanceledJobInSubmitted event, Emitter<ListJobState> emit) async {
    if (state is! ListCanceledJobLoading) {
      emit(ListCanceledJobLoading());
    }
    final result =
        await _canceledJob(PaginationParams(event.pageKey, event.pageSize, event.clientId));

    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          pagingController.itemList!.clear();

          return ErrorLoadingListCanceledJob(message: error.message);
        }
        return const ErrorLoadingListCanceledJob(message: 'Unknown Error');
      }, (canceledJob) => ListCanceledJobLoaded(canceledJob: canceledJob)),
    );
  }

  void _deleteJobEvent(
      DeleteJobEvent event, Emitter<ListJobState> emit) async {
    emit(DeleteJobLoading());
    final result = await _deleteJob(
        DeleteJobParams(id: event.id, freelancerId: event.freelancerId, clientId: event.clientId));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorLoadingDeleteJob(message: error.message);
        }
        return const ErrorLoadingDeleteJob(
            message: 'Error While Deleting Job');
      },
      (result) {
        return DeleteJobLoaded();
      },
    ));
  }
}
