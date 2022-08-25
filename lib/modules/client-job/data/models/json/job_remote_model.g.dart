// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobRemoteModel _$JobRemoteModelFromJson(Map<String, dynamic> json) =>
    JobRemoteModel(
      json['jobId'] as String,
      json['clientId'] as String?,
      (json['freelancerId'] as List<dynamic>?)
          ?.map(
              (e) => FreelancerRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['title'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      (json['budget'] as num).toDouble(),
      json['duration'] as int?,
      json['proposals'] as int,
      json['expiry'] as String?,
      json['language'] as String?,
      json['progress'] as String,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
    );

Map<String, dynamic> _$JobRemoteModelToJson(JobRemoteModel instance) =>
    <String, dynamic>{
      'jobId': instance.id,
      'clientId': instance.clientId,
      'freelancerId': instance.freelancerId,
      'title': instance.title,
      'skills': instance.skills,
      'budget': instance.budget,
      'duration': instance.duration,
      'proposals': instance.proposals,
      'expiry': instance.expiry,
      'language': instance.language,
      'progress': instance.progress,
      'startDate': instance.startDate?.toIso8601String(),
    };

BidRemoteModel _$BidRemoteModelFromJson(Map<String, dynamic> json) =>
    BidRemoteModel(
      json['freelancerId'] as String,
      (json['budget'] as num).toDouble(),
      json['hours'] as int,
      json['coverLetter'] as String,
      json['isTermsAndConditionAgreed'] as bool,
      DateTime.parse(json['createdAt'] as String),
      ProposalFreelancerRemoteModel.fromJson(
          json['freelancer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BidRemoteModelToJson(BidRemoteModel instance) =>
    <String, dynamic>{
      'freelancerId': instance.freelancerId,
      'budget': instance.budget,
      'hours': instance.hours,
      'coverLetter': instance.coverLetter,
      'isTermsAndConditionAgreed': instance.isTermsAndConditionAgreed,
      'createdAt': instance.createdAt.toIso8601String(),
      'freelancer': instance.freelancer,
    };

FreelancerRemoteModel _$FreelancerRemoteModelFromJson(
        Map<String, dynamic> json) =>
    FreelancerRemoteModel(
      json['freelancerId'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profilePicture'] as String,
    );

Map<String, dynamic> _$FreelancerRemoteModelToJson(
        FreelancerRemoteModel instance) =>
    <String, dynamic>{
      'freelancerId': instance.freelancerId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
    };

ProposalFreelancerRemoteModel _$ProposalFreelancerRemoteModelFromJson(
        Map<String, dynamic> json) =>
    ProposalFreelancerRemoteModel(
      json['firstName'] as String,
      json['lastName'] as String,
      json['profilePicture'] as String,
      json['numberOfReviews'] as int,
    );

Map<String, dynamic> _$ProposalFreelancerRemoteModelToJson(
        ProposalFreelancerRemoteModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicture': instance.profilePicture,
      'numberOfReviews': instance.numberOfReviews,
    };

FilterRemoteModel _$FilterRemoteModelFromJson(Map<String, dynamic> json) =>
    FilterRemoteModel(
      json['progress'] as String,
    );

Map<String, dynamic> _$FilterRemoteModelToJson(FilterRemoteModel instance) =>
    <String, dynamic>{
      'progress': instance.progress,
    };

JobDetailRemoteModel _$JobDetailRemoteModelFromJson(
        Map<String, dynamic> json) =>
    JobDetailRemoteModel(
      json['jobId'] as String,
      json['clientId'] as String?,
      (json['freelancerId'] as List<dynamic>?)
          ?.map(
              (e) => FreelancerRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['title'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      (json['budget'] as num).toDouble(),
      json['duration'] as int?,
      json['proposals'] as int,
      json['expiry'] as String?,
      json['category'] as String,
      json['language'] as String?,
      json['progress'] as String,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['description'] as String,
      json['files'] as List<dynamic>,
    );

Map<String, dynamic> _$JobDetailRemoteModelToJson(
        JobDetailRemoteModel instance) =>
    <String, dynamic>{
      'jobId': instance.id,
      'clientId': instance.clientId,
      'freelancerId': instance.freelancerId,
      'title': instance.title,
      'skills': instance.skills,
      'budget': instance.budget,
      'duration': instance.duration,
      'proposals': instance.proposals,
      'expiry': instance.expiry,
      'category': instance.category,
      'language': instance.language,
      'progress': instance.progress,
      'startDate': instance.startDate?.toIso8601String(),
      'links': instance.links,
      'description': instance.description,
      'files': instance.files,
    };

JobProposalRemoteModel _$JobProposalRemoteModelFromJson(
        Map<String, dynamic> json) =>
    JobProposalRemoteModel(
      json['jobId'] as String,
      json['clientId'] as String?,
      json['freelancerId'] as String?,
      json['title'] as String,
      (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      (json['budget'] as num).toDouble(),
      json['duration'] as int?,
      json['proposals'] as int,
      json['expiry'] as String?,
      json['category'] as String,
      json['language'] as String?,
      json['progress'] as String,
      json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['description'] as String,
      json['files'] as List<dynamic>,
      (json['bid'] as List<dynamic>)
          .map((e) => BidRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobProposalRemoteModelToJson(
        JobProposalRemoteModel instance) =>
    <String, dynamic>{
      'jobId': instance.id,
      'clientId': instance.clientId,
      'freelancerId': instance.freelancerId,
      'title': instance.title,
      'skills': instance.skills,
      'budget': instance.budget,
      'duration': instance.duration,
      'proposals': instance.proposals,
      'expiry': instance.expiry,
      'category': instance.category,
      'language': instance.language,
      'progress': instance.progress,
      'startDate': instance.startDate?.toIso8601String(),
      'links': instance.links,
      'description': instance.description,
      'files': instance.files,
      'bid': instance.bid,
    };

JobIdRemoteModel _$JobIdRemoteModelFromJson(Map<String, dynamic> json) =>
    JobIdRemoteModel(
      json['id'] as String,
    );

Map<String, dynamic> _$JobIdRemoteModelToJson(JobIdRemoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

MilestoneRemoteModel _$MilestoneRemoteModelFromJson(
        Map<String, dynamic> json) =>
    MilestoneRemoteModel(
      json['milestoneId'] as String,
      json['name'] as String,
      (json['budget'] as num).toDouble(),
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
      json['description'] as String,
      json['state'] as String,
      json['datePaid'] == null
          ? null
          : DateTime.parse(json['datePaid'] as String),
    );

Map<String, dynamic> _$MilestoneRemoteModelToJson(
        MilestoneRemoteModel instance) =>
    <String, dynamic>{
      'milestoneId': instance.milestoneId,
      'name': instance.name,
      'budget': instance.budget,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'description': instance.description,
      'state': instance.state,
      'datePaid': instance.datePaid?.toIso8601String(),
    };
