import 'package:clean_flutter/_core/cqrs.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/modules/freelancer/domain/entities/freelancer_basic.dart';
import 'package:clean_flutter/modules/freelancer/domain/entities/freelancer_detail.dart';
import 'package:dartz/dartz.dart';

abstract class FreelancerRepository {
  Future<Either<Failure, PaginatedQueryResult<List<FreelancerBasic>>>>
      listFreelancerBasic({pagination, filter, sort});
  Future<Either<Failure, FreelancerDetail>> getFreelancerDetail(String id);
}
