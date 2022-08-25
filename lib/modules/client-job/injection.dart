import 'package:clean_flutter/modules/client-job/data/data_source/job_remote_model.dart';
import 'package:clean_flutter/modules/client-job/data/data_source/local_data_source.dart';
import 'package:clean_flutter/modules/client-job/data/repositories/job_repository_impl.dart';
import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/edit_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/get_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/list_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/list_milestones.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/pending_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/post_job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/view_job_proposals.dart';
import 'package:clean_flutter/modules/client-job/views/job_detail/blocs/get_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_edit/bloc/edit_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_list/bloc/list_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_post/blocs/post_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/bloc/proposal_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecase/addMilestone.dart';
import 'domain/usecase/canceledJobs.dart';
import 'domain/usecase/changeProgress.dart';
import 'domain/usecase/completedJobs.dart';
import 'domain/usecase/deleteJob.dart';
import 'domain/usecase/hire_freelancer.dart';
import 'domain/usecase/ongoing_job.dart';
import 'domain/usecase/payFreelancer.dart';

void injectJobs(GetIt container) {
  //! Bloc Injection
  container.registerFactory(
    () => ListJobBloc(
      listJob: container(),
      pendingJob: container(),
      ongoingJob: container(),
      completedJob: container(),
      canceledJob: container(),
      deleteJob: container(),
    ),
  );
  container.registerFactory(
    () => JobDetailBloc(
        getJob: container(),
        changeProgress: container(),
        listMilestones: container(),
        payFreelancer: container(),
        addMilestone: container()),
  );
  container.registerFactory(
      () => JobEditBloc(editJob: container(), getJob: container()));
  container.registerFactory(() =>
      ProposalsBloc(viewProposals: container(), hireFreelancer: container()));
  container.registerFactory(() => JobPostBloc(postJob: container()));

  //! Data Source Injection
  container.registerLazySingleton<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(dio: container()));
  container.registerLazySingleton<JobLocalDataSource>(
      () => JobLocalDataSourceImpl(hive: container()));
  container.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );

  //! Use Case Injection
  container.registerLazySingleton(() => ListJob(repository: container()));
  container.registerLazySingleton(() => GetJobUseCase(repository: container()));
  container.registerLazySingleton(
      () => ChangeJobProgressJobUseCase(repository: container()));
  container.registerLazySingleton(
      () => ListMilestonesUseCase(repository: container()));
  container.registerLazySingleton(
      () => PayFreelancerUseCase(repository: container()));
  container.registerLazySingleton(() => PendingJob(repository: container()));
  container.registerLazySingleton(() => OngoingJob(repository: container()));
  container.registerLazySingleton(() => CompletedJob(repository: container()));
  container.registerLazySingleton(() => CanceledJob(repository: container()));
  container
      .registerLazySingleton(() => EditJobUseCase(repository: container()));
  container
      .registerLazySingleton(() => ProposalUseCase(repository: container()));
  container
      .registerLazySingleton(() => PostJobUseCase(repository: container()));
  container.registerLazySingleton(
      () => HireFreelancerUseCase(repository: container()));
  container
      .registerLazySingleton(() => DeleteJobUseCase(repository: container()));
  container.registerLazySingleton(
      () => AddMilestoneUseCase(repository: container()));
}
