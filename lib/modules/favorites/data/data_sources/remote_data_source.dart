import 'package:clean_flutter/modules/favorites/data/mappers/favorite_freelancer_mapper.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:dio/dio.dart';

abstract class FavoriteFreelancerRemoteDataSource {
  Future<List<FavoriteFreelancerEntity>> getFavoriteFreelancers(int page, int limit);
}

class FavoriteFreelancerRemoteDataSourceImpl
    implements FavoriteFreelancerRemoteDataSource {
  final Dio dio;

  FavoriteFreelancerRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FavoriteFreelancerEntity>> getFavoriteFreelancers(int page, int limit) async {
    final List<FavoriteFreelancerEntity> favoriteFreelancers = [];

    String path = "/clients/me/favorites?page=$page&limit=$limit";
    final response = await dio.get(path);
    response.data['data'].forEach((favFreelancer) => {
          favoriteFreelancers
              .add(FavoriteFreelancerMapper.fromJson(favFreelancer))
        });
    // ignore: avoid_print
    print(favoriteFreelancers.length);
    return favoriteFreelancers;
  }
}
