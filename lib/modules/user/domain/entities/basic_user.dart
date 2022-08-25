import 'package:equatable/equatable.dart';

class BasicUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String phone;
  final String description;
  final String email;
  final List<String> roles;
  final bool verified;
  final bool isEmailVerified;
  final String profilePicture;

  const BasicUser({required this.id,
      required this.isEmailVerified,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.phone,
      required this.description,
      required this.email,
      required this.roles,
      required this.verified,
      required this.profilePicture});

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
        isEmailVerified,
        profilePicture
      ];
}
