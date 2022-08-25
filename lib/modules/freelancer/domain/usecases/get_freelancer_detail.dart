import 'package:clean_flutter/modules/freelancer/domain/repo/freelancer_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_flutter/_core/error/failures.dart';

import '../../../../_core/usecase.dart';
import '../entities/freelancer_detail.dart';

class GetFreelancerDetailUseCase implements UseCase<FreelancerDetail, String> {
  final FreelancerRepository repository;

  GetFreelancerDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, FreelancerDetail>> call(String params) async {
    return await repository.getFreelancerDetail(params);
  }
}
