import 'package:clean_flutter/modules/user/data/json/create_remote_user.dart';
import 'package:clean_flutter/modules/user/data/mappers/basic_user_mapper.dart';
import 'package:clean_flutter/modules/user/data/mappers/detail_user_mapper.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../_core/error/exceptions.dart';
import '../../../../_core/error/failures.dart';
import '../../domain/repo/user_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      final token = await remoteDataSource.authenticate(email, password);
      localDataSource.cacheToken(token);
      return Right(token);
    } catch (err) {
      return Left(ServerFailure('Unknown error'));
    }
  }

  @override
  Future<Either<Failure, BasicUser>> getCurrentBasicUser() async {
    try {
      final remoteUser = await remoteDataSource.getBasicUser();
      // localDataSource
      // localDataSource.cacheBasicUser(BasicUserMapper.toModel(remoteUser));
      return Right(remoteUser);
    } catch (err) {
      try {
        final localUser = await localDataSource.getCachedBasicUser();
        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getCachedToken();
      if (token.isNotEmpty) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.removeToken();
      await localDataSource.removeUser();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register(payload) async {
    try {
      final clientId = await remoteDataSource.register(CreateUser(
        payload.firstName,
        payload.lastName,
        payload.phone,
        payload.email,
        payload.password,
      ).toJson());
      print(clientId);
      return Right(clientId);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure('Registration Not Successful'));
      }
    }

    return Left(ServerFailure("Unknown server error"));
  }

  @override
  Future<Either<Failure, void>> verifyEmail(
      {required String code, required String email}) async {
    try {
      final token = await remoteDataSource.verifyEmail(code, email);
      localDataSource.cacheToken(token);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyForgetEmail(
      {required String code, required String email}) async {
    try {
      final token = await remoteDataSource.verifyForgetEmail(code, email);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, void>> resendOTP(
      {required String email, required String type}) async {
    try {
      await remoteDataSource.resendOTP(email, type);
      return const Right(null);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }

      return Left(ServerFailure('unknown server error'));
    }
  }

  @override
  Future<Either<Failure, DetailUser>> getDetailUSer() async {
    try {
      print("no here");
      final remoteDetailUser = await remoteDataSource.getDetailUser();
      print(remoteDetailUser);
      localDataSource
          .cacheDetailUser(DetailUserMapper.toModel(remoteDetailUser));

      return Right(remoteDetailUser);
    } catch (err) {
      try {
        print('gn ezh gebtual');

        final localDetailUser = await localDataSource.getCachedDetailUser();
        print(localDetailUser);
        return Right(localDetailUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
