import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:dartz/dartz.dart';

import '../../../../_core/error/failures.dart';

abstract class UserRepository {
  /// Authenticates a user using his [username] and [password]
  Future<Either<Failure, String>> authenticate(
      {required String email, required String password});

  /// Returns whether the [User] is authenticated.
  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, BasicUser>> getCurrentBasicUser();

  Future<Either<Failure, DetailUser>> getDetailUSer();

  /// Logs out the [User]
  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, String>> register(payload);

  // email
  Future<Either<Failure, void>> verifyEmail(
      {required String code, required String email});
  Future<Either<Failure, void>> verifyForgetEmail(
      {required String code, required String email});
  Future<Either<Failure, void>> resendOTP(
      {required String email, required String type});
}
