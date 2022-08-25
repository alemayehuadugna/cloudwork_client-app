import 'package:json_annotation/json_annotation.dart';

part 'remote_favorite_freelancer.g.dart';

@JsonSerializable()
class RemoteFavoriteFreelancer {
  final String id;
  final String firstName;
  final String lastName;
  final AddressRemoteModel address;
  final String profilePicture;
  final List<String> skills;
  final String expertise;
  final RatingRemoteModel skillRating;
  final RatingRemoteModel qualityOfWorkRating;
  final RatingRemoteModel availabilityRating;
  final RatingRemoteModel adherenceToScheduleRating;
  final RatingRemoteModel communicationRating;
  final RatingRemoteModel cooperationRating;

  RemoteFavoriteFreelancer(
      this.id,
      this.firstName,
      this.lastName,
      this.address,
      this.profilePicture,
      this.skills,
      this.expertise,
      this.skillRating,
      this.qualityOfWorkRating,
      this.availabilityRating,
      this.adherenceToScheduleRating,
      this.communicationRating,
      this.cooperationRating);

  factory RemoteFavoriteFreelancer.fromJson(Map<String, dynamic> json) =>
      _$RemoteFavoriteFreelancerFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteFavoriteFreelancerToJson(this);
}

@JsonSerializable()
class RatingRemoteModel {
  final double rate;
  final double totalRate;
  final double totalRaters;

  const RatingRemoteModel(this.rate, this.totalRate, this.totalRaters);
  factory RatingRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$RatingRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingRemoteModelToJson(this);
}

@JsonSerializable()
class AddressRemoteModel {
  final String region;
  final String city;
  final String? areaName;
  final String? postalCode;

  const AddressRemoteModel(
      this.region, this.city, this.areaName, this.postalCode);

  factory AddressRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$AddressRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRemoteModelToJson(this);
}
