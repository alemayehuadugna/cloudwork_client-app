import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/modules/favorites/data/data_sources/local_data_source.dart';
import 'package:clean_flutter/modules/favorites/data/data_sources/remote_data_source.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:clean_flutter/modules/favorites/domain/repo/favorite_freelancer_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteFreelancersRepositoryImpl
    implements FavoriteFreelancerRepository {
  final FavoriteFreelancerRemoteDataSource remoteDataSource;
  final FavoriteFreelancerLocalDataSources localDataSources;

  FavoriteFreelancersRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSources});

  @override
  Future<Either<Failure, List<FavoriteFreelancerEntity>>>
      getFavoriteFreelancers(page, limit) async {
    try {
      final remoteFavoriteFreelancers =
          await remoteDataSource.getFavoriteFreelancers(page, limit);
      //TODO: cache to hive
      // localDataSources.cacheFavoriteFreelancers(remoteFavoriteFreelancers);
      return Right(remoteFavoriteFreelancers);
    } catch (err) {
      return Left(CacheFailure());
    }
  }
}
