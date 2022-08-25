import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_remote_model.g.dart';

@JsonSerializable()
class JobRemoteModel {
  @JsonKey(name: 'jobId')
  final String id;
  @JsonKey(name: 'clientId')
  final String? clientId;
  @JsonKey(name: 'freelancerId')
  final List<FreelancerRemoteModel>? freelancerId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'proposals')
  final int proposals;
  @JsonKey(name: 'expiry')
  late String? expiry;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String progress;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;

  JobRemoteModel(
    this.id,
    this.clientId,
    this.freelancerId,
    this.title,
    this.skills,
    this.budget,
    this.duration,
    this.proposals,
    this.expiry,
    this.language,
    this.progress,
    this.startDate,
  );

  factory JobRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobRemoteModelToJson(this);
  }
}

@JsonSerializable()
class BidRemoteModel {
  final String freelancerId;
  final double budget;
  final int hours;
  final String coverLetter;
  final bool isTermsAndConditionAgreed;
  final DateTime createdAt;
  ProposalFreelancerRemoteModel freelancer;

  BidRemoteModel(
    this.freelancerId,
    this.budget,
    this.hours,
    this.coverLetter,
    this.isTermsAndConditionAgreed,
    this.createdAt,
    this.freelancer,
  );

  factory BidRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$BidRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$BidRemoteModelToJson(this);
  }
}

@JsonSerializable()
class FreelancerRemoteModel {
  final String freelancerId;
  final String firstName;
  final String lastName;
  final String profilePicture;

  const FreelancerRemoteModel(
      this.freelancerId, this.firstName, this.lastName, this.profilePicture);

  factory FreelancerRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$FreelancerRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$FreelancerRemoteModelToJson(this);
  }
}

@JsonSerializable()
class ProposalFreelancerRemoteModel {
  final String firstName;
  final String lastName;
  final String profilePicture;
  final int numberOfReviews;

  const ProposalFreelancerRemoteModel(
      this.firstName, this.lastName, this.profilePicture, this.numberOfReviews);

  factory ProposalFreelancerRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$ProposalFreelancerRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$ProposalFreelancerRemoteModelToJson(this);
  }
}

@JsonSerializable()
class FilterRemoteModel {
  final String progress;

  const FilterRemoteModel(this.progress);

  Map<String, dynamic> toJson() {
    return _$FilterRemoteModelToJson(this);
  }
}

@JsonSerializable()
class JobDetailRemoteModel {
  @JsonKey(name: 'jobId')
  final String id;
  @JsonKey(name: 'clientId')
  final String? clientId;
  @JsonKey(name: 'freelancerId')
  final List<FreelancerRemoteModel>? freelancerId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'proposals')
  final int proposals;
  @JsonKey(name: 'expiry')
  late String? expiry;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String progress;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'links')
  final List<String>? links;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'files')
  final List<dynamic> files;

  JobDetailRemoteModel(
    this.id,
    this.clientId,
    this.freelancerId,
    this.title,
    this.skills,
    this.budget,
    this.duration,
    this.proposals,
    this.expiry,
    this.category,
    this.language,
    this.progress,
    this.startDate,
    this.links,
    this.description,
    this.files,
    // this.bid,
  );

  factory JobDetailRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobDetailRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobDetailRemoteModelToJson(this);
  }
}

@JsonSerializable()
class JobProposalRemoteModel {
  @JsonKey(name: 'jobId')
  final String id;
  @JsonKey(name: 'clientId')
  final String? clientId;
  @JsonKey(name: 'freelancerId')
  final String? freelancerId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'skills')
  final List<String> skills;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'proposals')
  final int proposals;
  @JsonKey(name: 'expiry')
  late String? expiry;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'progress')
  final String progress;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'links')
  final List<String>? links;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'files')
  final List<dynamic> files;
  @JsonKey(name: 'bid')
  final List<BidRemoteModel> bid;

  JobProposalRemoteModel(
    this.id,
    this.clientId,
    this.freelancerId,
    this.title,
    this.skills,
    this.budget,
    this.duration,
    this.proposals,
    this.expiry,
    this.category,
    this.language,
    this.progress,
    this.startDate,
    this.links,
    this.description,
    this.files,
    this.bid,
  );

  factory JobProposalRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobProposalRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobProposalRemoteModelToJson(this);
  }
}

@JsonSerializable()
class JobIdRemoteModel {
  final String id;

  const JobIdRemoteModel(
    this.id,
  );

  factory JobIdRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$JobIdRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$JobIdRemoteModelToJson(this);
  }
}

@JsonSerializable()
class MilestoneRemoteModel {
  final String milestoneId;
  final String name;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String state;
  final DateTime? datePaid;

  MilestoneRemoteModel(
    this.milestoneId,
    this.name,
    this.budget,
    this.startDate,
    this.endDate,
    this.description,
    this.state,
    this.datePaid
  );

  factory MilestoneRemoteModel.fromJson(Map<String, dynamic> json) {
    var x = _$MilestoneRemoteModelFromJson(json);
    return x;
  }

  Map<String, dynamic> toJson() {
    return _$MilestoneRemoteModelToJson(this);
  }
}
