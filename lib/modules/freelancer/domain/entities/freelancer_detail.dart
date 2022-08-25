import 'package:equatable/equatable.dart';

import '../../../../_shared/domain/entities/address.dart';
import '../../../../_shared/domain/entities/range_date.dart';
import '../../../../_shared/domain/entities/rating.dart';

class SocialLink extends Equatable {
  final String socialMedia;
  final String link;

  const SocialLink(this.socialMedia, this.link);

  @override
  List<Object?> get props => [socialMedia, link];
}

class Language extends Equatable {
  final String language;
  final String proficiencyLevel;

  const Language(this.language, this.proficiencyLevel);

  @override
  List<Object?> get props => [language, proficiencyLevel];
}

class Education extends Equatable {
  final String? id;
  final String institution;
  final RangeDate dateAttended;
  final String degree;
  final String areaOfStudy;
  final String description;

  const Education(this.institution, this.dateAttended, this.degree,
      this.areaOfStudy, this.description,
      {this.id});

  @override
  List<Object?> get props =>
      [institution, dateAttended, degree, areaOfStudy, description, id];
}

class Employment extends Equatable {
  final String? id;
  final String company;
  final String city;
  final String region;
  final String title;
  final RangeDate period;
  final String summary;

  const Employment(this.company, this.city, this.region, this.title,
      this.period, this.summary,
      {this.id});

  @override
  List<Object?> get props =>
      [company, city, region, title, period, summary, id];
}

class OtherExperience extends Equatable {
  final String? id;
  final String subject;
  final String description;

  const OtherExperience(this.subject, this.description, {this.id});

  @override
  List<Object?> get props => [subject, description, id];
}

class MainService extends Equatable {
  final String category;
  final String subcategory;

  const MainService(this.category, this.subcategory);

  @override
  List<Object?> get props => [category, subcategory];
}

class FreelancerDetail extends Equatable {
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
  final Rating skillRating;
  final Rating qualityOfWorkRating;
  final Rating availabilityRating;
  final Rating adherenceToScheduleRating;
  final Rating communicationRating;
  final Rating cooperationRating;
  final String? gender;
  final List<String> skills;
  final String overview;
  final String expertise;
  final bool verified;
  final String available;
  final Address? address;
  final List<SocialLink> socialLinks;
  final List<Language> languages;
  final List<Education> educations;
  final List<Employment> employments;
  final List<OtherExperience> otherExperiences;
  const FreelancerDetail(
    this.address, {
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.skills,
    required this.overview,
    required this.socialLinks,
    required this.languages,
    required this.educations,
    required this.employments,
    required this.otherExperiences,
    required this.completedJobs,
    required this.cancelledJobs,
    required this.numberOfReviews,
    required this.expertise,
    required this.verified,
    required this.joinedDate,
    required this.ongoingJobs,
    required this.skillRating,
    required this.qualityOfWorkRating,
    required this.availabilityRating,
    required this.adherenceToScheduleRating,
    required this.communicationRating,
    required this.cooperationRating,
    required this.available,
    required this.profilePicture,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        gender,
        skills,
        overview,
        socialLinks,
        address,
        languages,
        educations,
        employments,
        otherExperiences,
        completedJobs,
        cancelledJobs,
        numberOfReviews,
        expertise,
        verified,
        joinedDate,
        ongoingJobs,
        skillRating,
        qualityOfWorkRating,
        availabilityRating,
        adherenceToScheduleRating,
        communicationRating,
        cooperationRating,
        available,
        profilePicture,
        userName,
      ];
}
