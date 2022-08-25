import 'package:clean_flutter/modules/user/data/hive/basic_local_user.dart';
import 'package:clean_flutter/modules/user/data/json/basic_remote_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';

class BasicUserMapper {
  static BasicLocalUser toModel(BasicUser user) {
    return BasicLocalUser(
        user.id,
        user.firstName,
        user.lastName,
        user.userName,
        user.phone,
        user.description,
        user.email,
        user.roles,
        user.verified,
        user.isEmailVerified,
        user.profilePicture);
  }

  static BasicUser fromJson(Map<String, dynamic> json) {
    var user;

    try {
      user = BasicRemoteUser.fromJson(json);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    final BasicUser basicUser = BasicUser(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      userName: user.userName,
      phone: user.phone,
      description: user.description,
      email: user.email,
      roles: user.roles,
      verified: user.verified,
      isEmailVerified: user.isEmailVerified,
      profilePicture: user.profilePicture,
    );

    return basicUser;
  }
}
