import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteFreelancerRepository {
  Future<Either<Failure, List<FavoriteFreelancerEntity>>>
      getFavoriteFreelancers(int page, int limit);
}
