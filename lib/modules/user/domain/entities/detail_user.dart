import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/rating.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:equatable/equatable.dart';

class DetailUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String phone;
  final String email;
  final String description;
  final String websiteUrl;
  final Address? address;
  final List<SocialLink> socialLinks;
  final List<Favorite> favorites;
  final String companyName;
  final List<String> workCategory;
  final bool verified;
  final bool isEmailVerified;
  final String profilePicture;
  final Rating rating;
  final List<String> roles;
  final String profileUrl;
  final int completedJobs;
  final int ongoingJobs;
  final int cancelledJobs;
  final bool isProfileCompleted;
  final double profileCompletedPercentage;
  final double spending;
  final DateTime createdAt;

  const DetailUser(this.address,
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.phone,
      required this.email,
      required this.description,
      required this.websiteUrl,
      required this.companyName,
      required this.workCategory,
      required this.verified,
      required this.isEmailVerified,
      required this.profilePicture,
      required this.rating,
      required this.roles,
      required this.profileUrl,
      required this.completedJobs,
      required this.ongoingJobs,
      required this.cancelledJobs,
      required this.isProfileCompleted,
      required this.profileCompletedPercentage,
      required this.spending,
      required this.createdAt,
      required this.socialLinks,
      required this.favorites});

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        userName,
        phone,
        email,
        description,
        websiteUrl,
        companyName,
        workCategory,
        verified,
        isEmailVerified,
        profilePicture,
        rating,
        roles,
        profileUrl,
        completedJobs,
        ongoingJobs,
        cancelledJobs,
        isProfileCompleted,
        profileCompletedPercentage,
        spending,
        createdAt,
        socialLinks,
        favorites,
        address
      ];
}

// class SocialLink extends Equatable {
//   final String socialMedia;
//   final String link;

//   const SocialLink(this.socialMedia, this.link);

//   @override
//   List<Object?> get props => [socialMedia, link];
// }

class Favorite extends Equatable {
  final String freelancerId;

  const Favorite(this.freelancerId);

  @override
  List<Object?> get props => [freelancerId];
}
