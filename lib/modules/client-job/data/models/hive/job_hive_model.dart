import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';

import '../json/job_remote_model.dart';

part 'job_hive_model.g.dart';

@HiveType(typeId: 5)
class ProposalFreelancerHiveModel extends Equatable {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String profilePicture;

  @HiveField(3)
  final int numberOfReviews;

  const ProposalFreelancerHiveModel(
      this.firstName, this.lastName, this.profilePicture, this.numberOfReviews);

  @override
  List<Object?> get props =>
      [firstName, lastName, profilePicture, numberOfReviews];
}

@HiveType(typeId: 4)
class JobProposalHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? clientId;

  @HiveField(2)
  final String? freelancerId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final List<String> skills;

  @HiveField(5)
  final double budget;

  @HiveField(6)
  final int? duration;

  @HiveField(7)
  final int proposals;

  @HiveField(8)
  late String? expiry;

  @HiveField(9)
  final String category;

  @HiveField(10)
  final String language;

  @HiveField(11)
  final String progress;

  @HiveField(12)
  final DateTime? startDate;

  @HiveField(13)
  final List<String>? links;

  @HiveField(14)
  final String description;

  @HiveField(15)
  final List<PlatformFile> files;

  @HiveField(16)
  final List<BidHiveModel> bid;

  JobProposalHiveModel(
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

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        duration,
        proposals,
        expiry,
        category,
        language,
        progress,
        startDate,
        links,
        description,
        files,
        // bid
      ];
}

@HiveType(typeId: 3)
class BidHiveModel extends Equatable {
  @HiveField(0)
  final String freelancerId;

  @HiveField(1)
  final double budget;

  @HiveField(2)
  final int hours;

  @HiveField(3)
  final String coverLetter;

  @HiveField(4)
  final bool isTermsAndConditionAgreed;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  ProposalFreelancerHiveModel freelancer;

  BidHiveModel(
    this.freelancerId,
    this.budget,
    this.hours,
    this.coverLetter,
    this.isTermsAndConditionAgreed,
    this.createdAt,
    this.freelancer,
  );

  @override
  List<Object?> get props => [
        freelancerId,
        budget,
        hours,
        coverLetter,
        isTermsAndConditionAgreed,
        createdAt,
        freelancer
      ];
}

@HiveType(typeId: 2)
class FreelancerHiveModel extends Equatable {
  @HiveField(0)
  final String freelancerId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String profilePicture;

  const FreelancerHiveModel(
      this.freelancerId, this.firstName, this.lastName, this.profilePicture);

  @override
  List<Object?> get props =>
      [freelancerId, firstName, lastName, profilePicture];
}

@HiveType(typeId: 1)
class JobHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? clientId;

  @HiveField(2)
  final List<FreelancerHiveModel>? freelancerId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final List<String> skills;

  @HiveField(5)
  final double budget;

  @HiveField(6)
  final int? duration;

  @HiveField(7)
  final int proposals;

  @HiveField(8)
  late String? expiry;

  @HiveField(9)
  final String category;

  @HiveField(10)
  final String language;

  @HiveField(11)
  final String progress;

  // @HiveField(12)
  // final String experience;

  @HiveField(13)
  final DateTime? startDate;

  // @HiveField(14)
  // final List<String>? links;

  // @HiveField(15)
  // final String description;

  // @HiveField(16)
  // final List<PlatformFile> files;

  // @HiveField(17)
  // final List<BidHiveModel> bid;

  JobHiveModel(
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
    // this.experience,
    this.startDate,
    // this.links,
    // this.description,
    // this.files,
    // this.bid,
  );

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        duration,
        proposals,
        expiry,
        category,
        language,
        progress,
        // experience,
        startDate,
        // links,
        // description,
        // files,
        // bid,
      ];
}

@HiveType(typeId: 0)
class JobDetailHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? clientId;

  @HiveField(2)
  final List<FreelancerHiveModel>? freelancerId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final List<String> skills;

  @HiveField(5)
  final double budget;

  @HiveField(6)
  final int? duration;

  @HiveField(7)
  final int proposals;

  @HiveField(8)
  late String? expiry;

  @HiveField(9)
  final String category;

  @HiveField(10)
  final String language;

  @HiveField(11)
  final String progress;

  @HiveField(12)
  final DateTime? startDate;

  @HiveField(13)
  final List<String>? links;

  @HiveField(14)
  final String description;

  @HiveField(15)
  final List<PlatformFile> files;

  // @HiveField(17)
  // final List<BidHiveModel> bid;

  JobDetailHiveModel(
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

  @override
  List<Object?> get props => [
        id,
        clientId,
        freelancerId,
        title,
        skills,
        budget,
        duration,
        proposals,
        expiry,
        category,
        language,
        progress,
        startDate,
        links,
        description,
        files,
        // bid
      ];
}
