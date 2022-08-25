import 'package:json_annotation/json_annotation.dart';

import '../../../../user/data/json/detail_remote_user.dart';

part 'freelancer_basic_remote_model.g.dart';

@JsonSerializable()
class FreelancerBasicRemoteModel {
  @JsonKey(name: 'freelancerId')
  final String id;
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'address')
  final AddressRemoteModel address;

  final RatingRemoteModel skillRating;
  final RatingRemoteModel adherenceToScheduleRating;
  final RatingRemoteModel availabilityRating;
  final RatingRemoteModel communicationRating;
  final RatingRemoteModel cooperationRating;
  final RatingRemoteModel qualityOfWorkRating;

  @JsonKey(name: 'expertise')
  final String expertise;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'profilePicture')
  final String profilePicture;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'verified')
  final bool isVerified;

  FreelancerBasicRemoteModel(
      this.id,
      this.firstName,
      this.lastName,
      this.address,
      this.skillRating,
      this.adherenceToScheduleRating,
      this.availabilityRating,
      this.communicationRating,
      this.cooperationRating,
      this.qualityOfWorkRating,
      this.expertise,
      this.skills,
      this.profilePicture,
      this.gender,
      this.isVerified);

  factory FreelancerBasicRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerBasicRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreelancerBasicRemoteModelToJson(this);
}
