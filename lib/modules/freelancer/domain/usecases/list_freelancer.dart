import 'package:dartz/dartz.dart';

import '../../../../_core/cqrs.dart';
import '../../../../_core/error/failures.dart';
import '../../../../_core/usecase.dart';
import '../entities/freelancer_basic.dart';
import '../repo/freelancer_repository.dart';

class ListFreelancersUseCase
    implements
        UseCase<PaginatedQueryResult<List<FreelancerBasic>>, QueryParams> {
  final FreelancerRepository repository;

  ListFreelancersUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedQueryResult<List<FreelancerBasic>>>> call(
      QueryParams params) async {
    return await repository.listFreelancerBasic(
        pagination: params.pagination,
        filter: params.filter,
        sort: params.sort);
  }
}
