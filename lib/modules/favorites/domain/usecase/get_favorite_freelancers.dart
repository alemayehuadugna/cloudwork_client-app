import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:clean_flutter/modules/favorites/domain/repo/favorite_freelancer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetFavoriteFreelancersUsecase
    implements UseCase<List<FavoriteFreelancerEntity>, PaginationParams> {
  final FavoriteFreelancerRepository repository;

  GetFavoriteFreelancersUsecase({required this.repository});

  @override
  Future<Either<Failure, List<FavoriteFreelancerEntity>>> call(
      PaginationParams params) async {
    return await repository.getFavoriteFreelancers(params.page, params.limit);
  }
}

class PaginationParams extends Equatable {
  final int page;
  final int limit;

  const PaginationParams({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
