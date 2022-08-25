import 'package:clean_flutter/_shared/data/models/hive/common_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'detail_local_user.g.dart';

@HiveType(typeId: 20)
class DetailLocalUser extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String userName;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final String email;
  @HiveField(7)
  final List<String> roles;
  @HiveField(8)
  final bool verified;
  @HiveField(9)
  final String profilePicture;
  @HiveField(10)
  final bool isEmailVerified;

  @HiveField(11)
  final List<SocialLinkModel> socialLinks;

  @HiveField(12)
  final List<FavoriteModel> favorites;
  @HiveField(13)
  final RatingModel rating;
  @HiveField(14)
  final String profileUrl;
  @HiveField(15)
  final int completedJobs;
  @HiveField(16)
  final int ongoingJobs;
  @HiveField(17)
  final int cancelledJobs;
  @HiveField(18)
  final bool isProfileCompleted;
  @HiveField(19)
  final double profileCompletedPercentage;
  @HiveField(20)
  final double spending;
  @HiveField(21)
  final AddressModel? address;
  @HiveField(22)
  final List<String> workCategory;
  @HiveField(23)
  final String websiteUrl;
  @HiveField(24)
  final String companyName;

  @HiveField(25)
  final DateTime createdAt;

  const DetailLocalUser(
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
      this.socialLinks,
      this.favorites,
      this.rating,
      this.profileUrl,
      this.completedJobs,
      this.ongoingJobs,
      this.cancelledJobs,
      this.isProfileCompleted,
      this.profileCompletedPercentage,
      this.spending,
      this.address,
      this.workCategory,
      this.createdAt,
      this.websiteUrl,
      this.companyName);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        userName,
        phone,
        description,
        email,
        roles,
        verified,
        profilePicture,
        isEmailVerified,
        socialLinks,
        favorites,
        rating,
        profileUrl,
        completedJobs,
        ongoingJobs,
        cancelledJobs,
        isProfileCompleted,
        profileCompletedPercentage,
        spending,
        address
      ];
}

@HiveType(typeId: 21)
class SocialLinkModel extends Equatable {
  @HiveField(0)
  final String socialMedia;

  @HiveField(1)
  final String link;

  const SocialLinkModel(this.socialMedia, this.link);

  @override
  List<Object?> get props => [socialMedia, link];
}

@HiveType(typeId: 22)
class FavoriteModel extends Equatable {
  @HiveField(0)
  final String freelancerId;

  const FavoriteModel(this.freelancerId);

  @override
  List<Object?> get props => [freelancerId];
}
