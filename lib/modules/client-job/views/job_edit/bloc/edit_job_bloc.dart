import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/edit_job.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/usecase/get_job.dart';

part 'edit_job_event.dart';
part 'edit_job_state.dart';

class JobEditBloc extends Bloc<JobEditEvent, JobEditState> {
  final EditJobUseCase _editJob;
  final GetJobUseCase _getJob;

  JobEditBloc({required EditJobUseCase editJob, required GetJobUseCase getJob})
      : _editJob = editJob,
        _getJob = getJob,
        super(JobDetailForEditInitial()) {
    on<GetJobForEditEvent>(_getJobDetail);
    on<EditJobEvent>(_editJobDetail);
  }

  void _getJobDetail(
      GetJobForEditEvent event, Emitter<JobEditState> emit) async {
    emit(JobDetailForEditLoading());
    final result = await _getJob(JobParams(id: event.id));
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingJobDetailForEdit(message: error.message);
        }
        return const ErrorLoadingJobDetailForEdit(message: 'Unknown Error');
      }, (job) => JobDetailForEditLoaded(job: job)),
    );
  }

  void _editJobDetail(EditJobEvent event, Emitter<JobEditState> emit) async {
    emit(JobEditLoading());
    final result = await _editJob(event.payload);
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingJobEdit(message: error.message);
        }
        return const ErrorLoadingJobEdit(message: 'Unknown Error');
      }, (job) => JobEditLoaded(job: job)),
    );
  }
}
