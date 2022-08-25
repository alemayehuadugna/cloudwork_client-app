import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/post_job.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/error/failures.dart';

part 'post_job_event.dart';
part 'post_job_state.dart';

class JobPostBloc extends Bloc<JobPostEvent, JobPostState> {
  final PostJobUseCase _postJob;

  JobPostBloc({required PostJobUseCase postJob})
      : _postJob = postJob,
        super(JobPostInitial()) {
    on<PostJobEvent>(_postJobFunction);
  }

  void _postJobFunction(PostJobEvent event, Emitter<JobPostState> emit) async {
    emit(JobPostLoading());
    final result = await _postJob(event.payload);
    emit(
      result.fold((error) {
        if (error is ServerFailure) {
          return ErrorLoadingJobPost(message: error.message);
        }
        return const ErrorLoadingJobPost(message: 'Unknown Error');
      }, (job) => JobPostLoaded(job: job)),
    );
  }
}
