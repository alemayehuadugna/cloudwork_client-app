// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailRemoteUser _$DetailRemoteUserFromJson(Map<String, dynamic> json) =>
    DetailRemoteUser(
      json['clientId'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['userName'] as String,
      json['phone'] as String,
      json['description'] as String,
      json['email'] as String,
      (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      json['verified'] as bool,
      json['profilePicture'] as String,
      json['isEmailVerified'] as bool,
      RatingRemoteModel.fromJson(json['rating'] as Map<String, dynamic>),
      json['profileUrl'] as String,
      json['completedJobs'] as int,
      json['ongoingJobs'] as int,
      json['cancelledJobs'] as int,
      json['isProfileCompleted'] as bool,
      (json['profileCompletedPercentage'] as num).toDouble(),
      (json['spending'] as num).toDouble(),
      json['address'] == null
          ? null
          : AddressRemoteModel.fromJson(
              json['address'] as Map<String, dynamic>),
      (json['socialLinks'] as List<dynamic>?)
          ?.map(
              (e) => SocialLinkRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['favorites'] as List<dynamic>?)
          ?.map((e) => FavoriteRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['createdAt'] as String),
      (json['workCategory'] as List<dynamic>).map((e) => e as String).toList(),
      json['websiteUrl'] as String,
      json['companyName'] as String,
    );

Map<String, dynamic> _$DetailRemoteUserToJson(DetailRemoteUser instance) =>
    <String, dynamic>{
      'clientId': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'phone': instance.phone,
      'email': instance.email,
      'description': instance.description,
      'websiteUrl': instance.websiteUrl,
      'address': instance.address,
      'socialLinks': instance.socialLinks,
      'favorites': instance.favorites,
      'companyName': instance.companyName,
      'workCategory': instance.workCategory,
      'verified': instance.verified,
      'isEmailVerified': instance.isEmailVerified,
      'profilePicture': instance.profilePicture,
      'rating': instance.rating,
      'roles': instance.roles,
      'profileUrl': instance.profileUrl,
      'completedJobs': instance.completedJobs,
      'ongoingJobs': instance.ongoingJobs,
      'cancelledJobs': instance.cancelledJobs,
      'isProfileCompleted': instance.isProfileCompleted,
      'profileCompletedPercentage': instance.profileCompletedPercentage,
      'spending': instance.spending,
      'createdAt': instance.createdAt.toIso8601String(),
    };

AddressRemoteModel _$AddressRemoteModelFromJson(Map<String, dynamic> json) =>
    AddressRemoteModel(
      json['region'] as String,
      json['city'] as String,
      json['areaName'] as String?,
      json['postalCode'] as String?,
    );

Map<String, dynamic> _$AddressRemoteModelToJson(AddressRemoteModel instance) =>
    <String, dynamic>{
      'region': instance.region,
      'city': instance.city,
      'areaName': instance.areaName,
      'postalCode': instance.postalCode,
    };

SocialLinkRemoteModel _$SocialLinkRemoteModelFromJson(
        Map<String, dynamic> json) =>
    SocialLinkRemoteModel(
      json['socialMedia'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$SocialLinkRemoteModelToJson(
        SocialLinkRemoteModel instance) =>
    <String, dynamic>{
      'socialMedia': instance.socialMedia,
      'link': instance.link,
    };

FavoriteRemoteModel _$FavoriteRemoteModelFromJson(Map<String, dynamic> json) =>
    FavoriteRemoteModel(
      json['freelancerId'] as String,
    );

Map<String, dynamic> _$FavoriteRemoteModelToJson(
        FavoriteRemoteModel instance) =>
    <String, dynamic>{
      'freelancerId': instance.freelancerId,
    };

RatingRemoteModel _$RatingRemoteModelFromJson(Map<String, dynamic> json) =>
    RatingRemoteModel(
      (json['rate'] as num).toDouble(),
      (json['totalRate'] as num).toDouble(),
      (json['totalRaters'] as num).toDouble(),
    );

Map<String, dynamic> _$RatingRemoteModelToJson(RatingRemoteModel instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'totalRate': instance.totalRate,
      'totalRaters': instance.totalRaters,
    };
