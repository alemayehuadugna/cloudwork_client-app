import 'package:clean_flutter/modules/freelancer/data/data_source/remote_data_source.dart';
import 'package:clean_flutter/modules/freelancer/domain/entities/freelancer_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/entities/freelancer_basic.dart';
import '../../domain/repo/freelancer_repository.dart';

class FreelancerRepositoryImpl implements FreelancerRepository {
  final FreelancerRemoteDataSource remoteDataSource;

  FreelancerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedQueryResult<List<FreelancerBasic>>>>
      listFreelancerBasic({pagination, filter, sort}) async {
    try {
      final result = await remoteDataSource.listFreelancerBasic(
          pagination: pagination, filter: filter, sort: sort);
      return Right(result);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, FreelancerDetail>> getFreelancerDetail(
      String id) async {
    try {
      final remoteDetailUser = await remoteDataSource.getFreelancerDetail(id);
      return Right(remoteDetailUser);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unidentified server error'));
    }
  }
}
