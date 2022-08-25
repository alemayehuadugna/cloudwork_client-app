import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'basic_local_user.g.dart';

@HiveType(typeId: 15)
class BasicLocalUser extends Equatable {
  @HiveField(16)
  final String id;
  @HiveField(18)
  final String firstName;
  @HiveField(19)
  final String lastName;
  @HiveField(20)
  final String userName;
  @HiveField(21)
  final String phone;
  @HiveField(22)
  final String description;
  @HiveField(23)
  final String email;
  @HiveField(24)
  final List<String> roles;
  @HiveField(25)
  final bool verified;
  @HiveField(26)
  final String profilePicture;
  @HiveField(27)
  final bool isEmailVerified;

  const BasicLocalUser(
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.phone,
    this.description,
    this.email,
    this.roles,
    this.verified,
    this.isEmailVerified,
    this.profilePicture,
  );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        userName,
        phone,
        description,
        email,
        roles,
        verified,
        profilePicture,
      ];
}
