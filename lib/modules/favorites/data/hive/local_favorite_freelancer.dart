import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../_shared/data/models/hive/common_model.dart';

part 'local_favorite_freelancer.g.dart';

@HiveType(typeId: 16)
class LocalFavoriteFreelancer extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final AddressModel address;
  @HiveField(4)
  final String profilePicture;
  @HiveField(5)
  final List<String> skills;
  @HiveField(6)
  final String expertise;
  @HiveField(7)
  final RatingModel skillRating;
  @HiveField(8)
  final RatingModel qualityOfWorkRating;
  @HiveField(9)
  final RatingModel availabilityRating;
  @HiveField(10)
  final RatingModel adherenceToScheduleRating;
  @HiveField(11)
  final RatingModel communicationRating;
  @HiveField(12)
  final RatingModel cooperationRating;

  const LocalFavoriteFreelancer(
      this.id,
      this.firstName,
      this.lastName,
      this.address,
      this.profilePicture,
      this.skills,
      this.expertise,
      this.skillRating,
      this.qualityOfWorkRating,
      this.availabilityRating,
      this.adherenceToScheduleRating,
      this.communicationRating,
      this.cooperationRating);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        address,
        profilePicture,
        skills,
        expertise,
        skillRating,
        qualityOfWorkRating,
        availabilityRating,
        adherenceToScheduleRating,
        communicationRating,
        cooperationRating
      ];
}
