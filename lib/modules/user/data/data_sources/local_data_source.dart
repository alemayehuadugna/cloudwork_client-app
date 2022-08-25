import 'package:clean_flutter/modules/user/data/hive/basic_local_user.dart';
import 'package:clean_flutter/modules/user/data/hive/detail_local_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:hive/hive.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/utils/constants.dart';

abstract class AuthLocalDataSource {
  Future<BasicUser> getCachedBasicUser();
  Future<DetailUser> getCachedDetailUser();

  Future<String> getCachedToken();

  Future<void> cacheToken(String token);

  // Future<void> cacheUser(UserModel userToCache);

  Future<void> cacheBasicUser(BasicLocalUser basicLocalUser);

  Future<void> cacheDetailUser(DetailLocalUser detailLocalUser);

  Future<void> removeToken();

  Future<void> removeUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveInterface hive;

  AuthLocalDataSourceImpl({required this.hive});

  @override
  Future<void> cacheToken(String token) async {
    try {
      var tokenBox = await hive.openBox('token');
      print("save argual");
      tokenBox.put(cachedToken, token);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBasicUser(BasicLocalUser basicLocalUser) async {
    try {
      var userBox = await hive.openLazyBox('user');
      userBox.put(cachedUser, basicLocalUser);
      // userBox.close();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<BasicUser> getCachedBasicUser() async {
    final userBox = await hive.openBox('user');
    final cachedData = userBox.get(cachedUser);

    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedToken() async {
    final tokenBox = await hive.openBox('token');
    final cachedData = tokenBox.get(cachedToken);
    if (cachedData != null) {
      return Future.value(cachedData);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> removeToken() async {
    var tokenBox = await hive.openBox('token');
    tokenBox.delete(cachedToken);
    tokenBox.close();
    return;
  }

  @override
  Future<void> removeUser() async {
    final userBox = await hive.openLazyBox('user');
    userBox.delete(cachedUser);

    return;
  }

  @override
  Future<void> cacheDetailUser(DetailLocalUser detailLocalUser) async {
    try {
      var userBox = await hive.openLazyBox<DetailLocalUser>('detail_user');
      userBox.put(cachedDetailUserKey, detailLocalUser);
      // userBox.close();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<DetailUser> getCachedDetailUser() async {
    final userBox = await hive.openBox('detail_user');
    final cachedDetailUserData = userBox.get(cachedDetailUserKey);

    if (cachedDetailUserData != null) {
      return Future.value(cachedDetailUserData);
    } else {
      throw CacheException();
    }
  }
}
