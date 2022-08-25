import 'package:json_annotation/json_annotation.dart';

part 'detail_remote_user.g.dart';

@JsonSerializable()
class DetailRemoteUser {
  @JsonKey(name: 'clientId')
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String phone;
  final String email;
  final String description;
  final String websiteUrl;
  AddressRemoteModel? address;
  List<SocialLinkRemoteModel> socialLinks;
  List<FavoriteRemoteModel> favorites;
  final String companyName;
  final List<String> workCategory;
  final bool verified;
  final bool isEmailVerified;
  final String profilePicture;
  final RatingRemoteModel rating;
  final List<String> roles;
  final String profileUrl;
  final int completedJobs;
  final int ongoingJobs;
  final int cancelledJobs;
  final bool isProfileCompleted;
  final double profileCompletedPercentage;
  final double spending;
  final DateTime createdAt;
  DetailRemoteUser(
      this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.phone,
      this.description,
      this.email,
      this.roles,
      this.verified,
      this.profilePicture,
      this.isEmailVerified,
      this.rating,
      this.profileUrl,
      this.completedJobs,
      this.ongoingJobs,
      this.cancelledJobs,
      this.isProfileCompleted,
      this.profileCompletedPercentage,
      this.spending,
      this.address,
      List<SocialLinkRemoteModel>? socialLinks,
      List<FavoriteRemoteModel>? favorites,
      this.createdAt,
      this.workCategory,
      this.websiteUrl,
      this.companyName)
      : socialLinks = socialLinks ?? <SocialLinkRemoteModel>[],
        favorites = favorites ?? <FavoriteRemoteModel>[];

  factory DetailRemoteUser.fromJson(Map<String, dynamic> json) =>
      _$DetailRemoteUserFromJson(json);
  Map<String, dynamic> toJson() => _$DetailRemoteUserToJson(this);
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

@JsonSerializable()
class SocialLinkRemoteModel {
  final String socialMedia;
  final String link;

  const SocialLinkRemoteModel(this.socialMedia, this.link);

  factory SocialLinkRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkRemoteModelToJson(this);
}

@JsonSerializable()
class FavoriteRemoteModel {
  final String freelancerId;

  const FavoriteRemoteModel(this.freelancerId);

  factory FavoriteRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRemoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteRemoteModelToJson(this);
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
