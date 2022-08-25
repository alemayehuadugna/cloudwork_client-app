import 'package:clean_flutter/modules/user/views/sign_up/widgets/sign_up_form.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/json/job_remote_model.dart';

class JobEntity extends Equatable {
  final String id;
  final String? clientId;
  final List<FreelancerEntity>? freelancerId;
  final String title;
  final List<String> skills;
  final double budget;
  final int? duration;
  final int proposals;
  late String? expiry;
  final String? language;
  final String progress;
  final DateTime? startDate;

  JobEntity({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.title,
    required this.skills,
    required this.budget,
    required this.duration,
    required this.proposals,
    required this.expiry,
    required this.language,
    required this.progress,
    required this.startDate,
  });

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
        language,
        progress,
        startDate,
      ];
}

class BidEntity extends Equatable {
  final String freelancerId;
  final double budget;
  final int hours;
  final String coverLetter;
  final bool isTermsAndConditionAgreed;
  final DateTime createdAt;
  ProposalFreelancerEntity freelancer;

  BidEntity(this.freelancerId, this.budget, this.hours, this.coverLetter,
      this.isTermsAndConditionAgreed, this.createdAt, this.freelancer);

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

class FreelancerEntity extends Equatable {
  final String freelancerId;
  final String firstName;
  final String lastName;
  final String profilePicture;

  const FreelancerEntity(
      this.freelancerId, this.firstName, this.lastName, this.profilePicture);

  @override
  List<Object?> get props =>
      [freelancerId, firstName, lastName, profilePicture];
}

class ProposalFreelancerEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String profilePicture;
  final int numberOfReviews;

  const ProposalFreelancerEntity(
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.numberOfReviews,
  );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        profilePicture,
        numberOfReviews,
      ];
}

class JobDetailEntity extends Equatable {
  final String id;
  final String? clientId;
  final List<FreelancerEntity>? freelancerId;
  final String title;
  final List<String> skills;
  final double budget;
  final int? duration;
  final int proposals;
  late String? expiry;
  final String category;
  final String? language;
  final String progress;
  final DateTime? startDate;
  final List<String>? links;
  final String description;
  final List<dynamic> files;
  // final List<BidEntity> bid;

  JobDetailEntity({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.title,
    required this.skills,
    required this.budget,
    required this.duration,
    required this.proposals,
    required this.expiry,
    required this.category,
    required this.language,
    required this.progress,
    required this.startDate,
    required this.links,
    required this.description,
    required this.files,
    // required this.bid,
  });

  JobDetailEntity.create({
    required this.id,
    required this.title,
    required this.clientId,
    required this.skills,
    required this.budget,
    required this.duration,
    required this.expiry,
    required this.category,
    required this.language,
    required this.links,
    required this.description,
    required this.files,
  })  : this.startDate = null,
        this.progress = '',
        this.freelancerId = null,
        this.proposals = 0;
  // this.bid = [];

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

class JobProposalEntity extends Equatable {
  final String id;
  final String? clientId;
  final String? freelancerId;
  final String title;
  final List<String> skills;
  final double budget;
  final int? duration;
  final int proposals;
  late String? expiry;
  final String category;
  final String? language;
  final String progress;
  final DateTime? startDate;
  final List<String>? links;
  final String description;
  final List<dynamic> files;
  final List<BidEntity> bid;

  JobProposalEntity({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.title,
    required this.skills,
    required this.budget,
    required this.duration,
    required this.proposals,
    required this.expiry,
    required this.category,
    required this.language,
    required this.progress,
    required this.startDate,
    required this.links,
    required this.description,
    required this.files,
    required this.bid,
  });

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
        bid
      ];
}

class JobIdEntity extends Equatable {
  final String id;

  const JobIdEntity({required this.id});

  @override
  List<Object?> get props => [id];
}

class MilestoneEntity extends Equatable {
  final String milestoneId;
  final String name;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String state;
  final DateTime? datePaid;

  MilestoneEntity(this.milestoneId, this.name, this.budget, this.startDate, this.endDate,
      this.description, this.state, this.datePaid);

  @override
  List<Object?> get props =>
      [milestoneId, name, budget, startDate, endDate, description, state, datePaid];
}
