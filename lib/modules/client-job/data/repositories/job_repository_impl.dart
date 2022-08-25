import 'package:clean_flutter/_core/cqrs.dart';
import 'package:clean_flutter/_core/error/exceptions.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/modules/client-job/common/params.dart';
import 'package:clean_flutter/modules/client-job/data/data_source/job_remote_model.dart';
import 'package:clean_flutter/modules/client-job/data/data_source/local_data_source.dart';
import 'package:clean_flutter/modules/client-job/data/mappers/job_mapper.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/repo/job_repository.dart';
import 'package:clean_flutter/_shared/domain/usecase/list_categories.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/changeProgress.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/hire_freelancer.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/payFreelancer.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/usecase/addMilestone.dart';
import '../../domain/usecase/deleteJob.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;
  final JobLocalDataSource localDataSource;

  JobRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<JobEntity>>> listJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.listJobs(params);
      localDataSource.cacheJobs(remoteJob);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.listCachedJobs();
          return Right(JobMapper.toLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, JobDetailEntity>> getJob(JobParams params) async {
    try {
      final remoteJob = await remoteDataSource.getJob(params);
      return Right(JobMapper.jobDetailToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.getJob();
          return Right(JobMapper.jobDetailToLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> pendingJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.pendingJob(params);
      localDataSource.cachePendingJobs(remoteJob);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.listCachedPendingJobs();
          return Right(JobMapper.toLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, JobDetailEntity>> editJob(
      JobDetailEntity params) async {
    try {
      final remoteJob = await remoteDataSource.editJob(params);
      return Right(
        JobMapper.jobDetailToRemoteEntity(remoteJob),
      );
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, JobProposalEntity>> viewProposals(
      JobParams params) async {
    try {
      final remoteJob = await remoteDataSource.viewProposals(params);
      return Right(JobMapper.jobProposalToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, JobDetailEntity>> postJob(
      JobDetailEntity params) async {
    try {
      final remoteJob = await remoteDataSource.postJob(params);
      return Right(
        JobMapper.jobDetailToRemoteEntity(remoteJob),
      );
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> ongoingJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.ongoingJob(params);
      localDataSource.cacheOngoingJobs(remoteJob);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.listCachedOngoingJobs();
          return Right(JobMapper.toLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> completedJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.completedJob(params);
      localDataSource.cacheCompletedJobs(remoteJob);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.listCachedCompletedJobs();
          return Right(JobMapper.toLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> cancelJobs(
      PaginationParams params) async {
    try {
      final remoteJob = await remoteDataSource.canceledJob(params);
      localDataSource.cacheCanceledJobs(remoteJob);
      return Right(JobMapper.toRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else if (err != DioError) {
        try {
          final localJob = await localDataSource.listCachedCanceledJobs();
          return Right(JobMapper.toLocalEntity(localJob));
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, JobIdEntity>> changeProgressJob(
      ProgressParams params) async {
    try {
      final remoteJob = await remoteDataSource.changeProgress(params);
      return Right(JobMapper.jobIdToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, JobIdEntity>> hireFreelancer(HireParams params) async {
    try {
      final remoteJob = await remoteDataSource.hireFreelancer(params);
      return Right(JobMapper.jobIdToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

  @override
  Future<Either<Failure, PaginatedQueryResult<List<MilestoneEntity>>>>
      listMilestones({pagination, filter, sort, jobId, type}) async {
    try {
      final milestones = await remoteDataSource.listMilestones(
          pagination: pagination,
          filter: filter,
          sort: sort,
          jobId: jobId,
          type: type);
      return Right(
        PaginatedQueryResult(
          data: JobMapper.milestoneToRemoteEntity(milestones.data!),
          page: milestones.page,
        ),
      );
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, JobIdEntity>> payFreelancer(
      PaymentParams params) async {
    try {
      final remoteJob = await remoteDataSource.payFreelancer(params);
      return Right(JobMapper.jobIdToRemoteEntity(remoteJob));
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      } else {
        return Left(ServerFailure('unknown server error'));
      }
    }
  }

   @override
  Future<Either<Failure, String>> deleteJob(
      DeleteJobParams params) async {
    try {
      final remoteJob = await remoteDataSource.deleteJob(params);
      return Right(remoteJob);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, String>> addMilestone(
      AddMilestoneParams params) async {
    try {
      final remoteJob = await remoteDataSource.addMilestone(params);
      return Right(remoteJob);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }
}
