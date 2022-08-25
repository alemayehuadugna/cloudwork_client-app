// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicRemoteUser _$BasicRemoteUserFromJson(Map<String, dynamic> json) =>
    BasicRemoteUser(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['userName'] as String,
      json['phone'] as String,
      json['description'] as String,
      json['email'] as String,
      (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      json['verified'] as bool,
      json['isEmailVerified'] as bool,
      json['profilePicture'] as String,
    );

Map<String, dynamic> _$BasicRemoteUserToJson(BasicRemoteUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'phone': instance.phone,
      'description': instance.description,
      'email': instance.email,
      'roles': instance.roles,
      'verified': instance.verified,
      'isEmailVerified': instance.isEmailVerified,
      'profilePicture': instance.profilePicture,
    };
