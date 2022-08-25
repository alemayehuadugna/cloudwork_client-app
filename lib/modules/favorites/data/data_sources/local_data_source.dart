import 'dart:convert';

import 'package:clean_flutter/_core/error/exceptions.dart';
import 'package:clean_flutter/modules/favorites/data/hive/local_favorite_freelancer.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:hive/hive.dart';

import '../json/remote_favorite_freelancer.dart';

abstract class FavoriteFreelancerLocalDataSources {
  Future<List<FavoriteFreelancerEntity>> getCachedFavoriteFreelancers();
  Future<void> cacheFavoriteFreelancers(
      List<RemoteFavoriteFreelancer> favoriteFreelancersToCache);
}

class FavoriteFreelancerLocalDataSourcesImpl
    implements FavoriteFreelancerLocalDataSources {
  final HiveInterface hive;

  FavoriteFreelancerLocalDataSourcesImpl({required this.hive});

  @override
  Future<List<FavoriteFreelancerEntity>> getCachedFavoriteFreelancers() async {
    final favoriteFreelancersBox = await hive.openBox('favoriteFreelancers');
    final cachedFavoriteFreelancers =
        favoriteFreelancersBox.get('cachedFavoriteFreelancersKey');
    if (cachedFavoriteFreelancers != null) {
      return Future.value(cachedFavoriteFreelancers);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheFavoriteFreelancers(
      List<RemoteFavoriteFreelancer> favoriteFreelancersToCache) async {
    try {
      var favoriteFreelancers = [];
      var favoriteFreelancersBox = await hive.openBox('favoriteFreelancers');
      favoriteFreelancersToCache.forEach((element) {
        favoriteFreelancers.add(json.encode(element.toJson()));
      });
      favoriteFreelancersBox.put(
          'cachedFavoriteFreelancersKey', favoriteFreelancers);
    } catch (err) {
      throw CacheException();
    }
  }
}
