import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:dartz/dartz.dart';

import '../../../../_shared/domain/entities/social_link.dart';

abstract class SettingRepository {
  Future<Either<Failure, String>> changePassword(
      {required String oldPassword, required String newPassword});

  Future<Either<Failure, String>> uploadProfilePicture({required var file});

  Future<Either<Failure, String>> updateBasicProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone});

  Future<Either<Failure, String>> updateAddress({required Address address});

  Future<Either<Failure, String>> updateDescription(
      {required String description});

  Future<Either<Failure, String>> updateOverview(
      {required String companyName, required String websiteUrl});
  Future<Either<Failure, String>> updateSocialLinks(
      {required List<SocialLink> socialLinks});

  Future<Either<Failure, String>> deleteAccount(
      {required String reason, required String password});

  Future<Either<Failure, String>> feedback(
      {required String firstName,
      required String lastName,
      required String message,
      required String title});

  Future<Either<Failure, String>> resetPassword(
      {required String email, required String password});
}
