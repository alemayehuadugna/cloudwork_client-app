// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_basic_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreelancerBasicRemoteModel _$FreelancerBasicRemoteModelFromJson(
        Map<String, dynamic> json) =>
    FreelancerBasicRemoteModel(
      json['freelancerId'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      AddressRemoteModel.fromJson(json['address'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(json['skillRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['adherenceToScheduleRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['availabilityRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['communicationRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['cooperationRating'] as Map<String, dynamic>),
      RatingRemoteModel.fromJson(
          json['qualityOfWorkRating'] as Map<String, dynamic>),
      json['expertise'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      json['profilePicture'] as String,
      json['gender'] as String,
      json['verified'] as bool,
    );

Map<String, dynamic> _$FreelancerBasicRemoteModelToJson(
        FreelancerBasicRemoteModel instance) =>
    <String, dynamic>{
      'freelancerId': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'skillRating': instance.skillRating,
      'adherenceToScheduleRating': instance.adherenceToScheduleRating,
      'availabilityRating': instance.availabilityRating,
      'communicationRating': instance.communicationRating,
      'cooperationRating': instance.cooperationRating,
      'qualityOfWorkRating': instance.qualityOfWorkRating,
      'expertise': instance.expertise,
      'skills': instance.skills,
      'profilePicture': instance.profilePicture,
      'gender': instance.gender,
      'verified': instance.isVerified,
    };
