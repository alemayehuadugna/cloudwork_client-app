// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_favorite_freelancer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteFavoriteFreelancer _$RemoteFavoriteFreelancerFromJson(
        Map<String, dynamic> json) =>
    RemoteFavoriteFreelancer(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      AddressRemoteModel.fromJson(json['address'] as Map<String, dynamic>),
      json['profilePicture'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      json['expertise'] as String,
      RatingRemoteModel.fromJson(json['skillRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['qualityOfWorkRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['availabilityRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['adherenceToScheduleRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['communicationRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['cooperationRating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteFavoriteFreelancerToJson(
        RemoteFavoriteFreelancer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
      'skills': instance.skills,
      'expertise': instance.expertise,
      'skillRating': instance.skillRating,
      'qualityOfWorkRating': instance.qualityOfWorkRating,
      'availabilityRating': instance.availabilityRating,
      'adherenceToScheduleRating': instance.adherenceToScheduleRating,
      'communicationRating': instance.communicationRating,
      'cooperationRating': instance.cooperationRating,
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
