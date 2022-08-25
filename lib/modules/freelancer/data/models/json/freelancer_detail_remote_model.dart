import 'package:json_annotation/json_annotation.dart';

part 'freelancer_detail_remote_model.g.dart';

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
class RangeDateRemoteModel {
  final DateTime start;
  final DateTime end;

  const RangeDateRemoteModel(this.start, this.end);

  factory RangeDateRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$RangeDateRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$RangeDateRemoteModelToJson(this);
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
class SocialLinkRemoteModel {
  final String socialMedia;
  final String link;

  const SocialLinkRemoteModel(this.socialMedia, this.link);

  factory SocialLinkRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkRemoteModelToJson(this);
}

@JsonSerializable()
class LanguageRemoteModel {
  final String language;
  final String proficiencyLevel;

  const LanguageRemoteModel(this.language, this.proficiencyLevel);

  factory LanguageRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageRemoteModelToJson(this);
}

@JsonSerializable()
class EducationRemoteModel {
  final String institution;
  final RangeDateRemoteModel dateAttended;
  final String degree;
  final String areaOfStudy;
  final String description;
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String? id;

  const EducationRemoteModel(this.institution, this.dateAttended, this.degree,
      this.areaOfStudy, this.description,
      {this.id});

  factory EducationRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$EducationRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationRemoteModelToJson(this);
}

@JsonSerializable()
class EmploymentRemoteModel {
  final String company;
  final String city;
  final String region;
  final String title;
  final RangeDateRemoteModel period;
  final String summary;
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String? id;

  const EmploymentRemoteModel(this.company, this.city, this.region, this.title,
      this.period, this.summary,
      {this.id});

  factory EmploymentRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$EmploymentRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentRemoteModelToJson(this);
}

@JsonSerializable()
class OtherExperienceRemoteModel {
  final String subject;
  final String description;
  static toNull(_) => null;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String? id;

  const OtherExperienceRemoteModel(this.subject, this.description, {this.id});

  factory OtherExperienceRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$OtherExperienceRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtherExperienceRemoteModelToJson(this);
}



@JsonSerializable()
class FreelancerDetailRemoteModel {
  final String id;
  final String firstName;
  final String lastName;
  
  
  final String userName;
  final String profilePicture;
  final int completedJobs;
  final int ongoingJobs;
  final int cancelledJobs;
  final int numberOfReviews;
  final DateTime joinedDate;
  
  
  final RatingRemoteModel skillRating;
  final RatingRemoteModel qualityOfWorkRating;
  final RatingRemoteModel availabilityRating;
  final RatingRemoteModel adherenceToScheduleRating;
  final RatingRemoteModel communicationRating;
  final RatingRemoteModel cooperationRating;
  final String? gender;
  final List<String> skills;
  final String overview;
  final String expertise;
  final bool verified;
  final String available;
  AddressRemoteModel? address;
  List<SocialLinkRemoteModel> socialLinks;
  List<LanguageRemoteModel> languages;
  List<EducationRemoteModel> educations;
  List<EmploymentRemoteModel> employments;
  List<OtherExperienceRemoteModel> otherExperiences;

  FreelancerDetailRemoteModel(
      this.id,
      this.firstName,
      this.lastName,
      
      this.gender,
      this.skills,
      this.overview,
      this.completedJobs,
      this.ongoingJobs,
      this.cancelledJobs,
      this.numberOfReviews,
      this.expertise,
      this.verified,
      this.joinedDate,
      this.profilePicture,
      this.userName,
      
      this.skillRating,
      this.qualityOfWorkRating,
      this.availabilityRating,
      this.adherenceToScheduleRating,
      this.communicationRating,
      this.cooperationRating,
      
      this.available,
      
      this.address,
      List<SocialLinkRemoteModel>? socialLinks,
      List<LanguageRemoteModel>? languages,
      List<EducationRemoteModel>? educations,
      List<EmploymentRemoteModel>? employments,
      List<OtherExperienceRemoteModel>? otherExperiences)
      : socialLinks = socialLinks ?? <SocialLinkRemoteModel>[],
        languages = languages ?? <LanguageRemoteModel>[],
        educations = educations ?? <EducationRemoteModel>[],
        employments = employments ?? <EmploymentRemoteModel>[],
        otherExperiences = otherExperiences ?? <OtherExperienceRemoteModel>[];

  factory FreelancerDetailRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerDetailRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreelancerDetailRemoteModelToJson(this);
}
