import 'package:json_annotation/json_annotation.dart';

part 'basic_remote_user.g.dart';

@JsonSerializable()
class BasicRemoteUser {
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

  const BasicRemoteUser(
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

  factory BasicRemoteUser.fromJson(Map<String, dynamic> json) =>
      _$BasicRemoteUserFromJson(json);

  Map<String, dynamic> toJson() => _$BasicRemoteUserToJson(this);
}
