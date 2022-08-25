import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/settings/data/data_sources/remote_data_source.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource settingRemoteDataSource;

  SettingRepositoryImpl({required this.settingRemoteDataSource});

  @override
  Future<Either<Failure, String>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final clientId = await settingRemoteDataSource.changePassword(
          oldPassword, newPassword);
      print(clientId);
      return Right(clientId);
    } catch (err) {
      print("ezh gebtual");
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(
      {required final file}) async {
    try {
      String profilePictureUrl =
          await settingRemoteDataSource.uploadProfilePicture(file);
      return Right(profilePictureUrl);
    } catch (err) {
      if (err is DioError) {
        return Left(ServerFailure(err.response!.data['message']));
      }
      return Left(ServerFailure('unknown server error when uploading picture'));
    }
  }

  @override
  Future<Either<Failure, String>> updateBasicProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone}) async {
    try {
      final clientId = await settingRemoteDataSource.updateBasicProfile(
          firstName, lastName, email, phone);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> updateDescription(
      {required String description}) async {
    try {
      final clientId =
          await settingRemoteDataSource.updateDescription(description);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> updateOverview(
      {required String companyName, required String websiteUrl}) async {
    try {
      final clientId =
          await settingRemoteDataSource.updateOverview(companyName, websiteUrl);

      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure('unknown error'));
    }
  }

  @override
  Future<Either<Failure, String>> updateAddress(
      {required Address address}) async {
    try {
      final clientId = await settingRemoteDataSource.updateAddress(address);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> updateSocialLinks(
      {required List<SocialLink> socialLinks}) async {
    try {
      final clientId =
          await settingRemoteDataSource.updateSocialLinks(socialLinks);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount(
      {required String reason, required String password}) async {
    try {
      final clientId =
          await settingRemoteDataSource.deleteAccount(reason, password);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> feedback(
      {required String firstName,
      required String lastName,
      required String message,
      required String title}) async {
    try {
      final feedbackId = await settingRemoteDataSource.feedback(
          firstName, lastName, message, title);
      return Right(feedbackId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required String email, required String password}) async {
    try {
      final clientId =
          await settingRemoteDataSource.resetPassword(email, password);
      print(clientId);
      return Right(clientId);
    } catch (err) {
      return Left(ServerFailure("unknown error"));
    }
  }

  // final
}
