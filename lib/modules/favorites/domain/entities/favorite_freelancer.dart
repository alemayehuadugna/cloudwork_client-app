import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/rating.dart';
import 'package:equatable/equatable.dart';

class FavoriteFreelancerEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final Address address;
  final String profilePicture;
  final List<String> skills;
  final String expertise;
  final Rating skillRating;
  final Rating qualityOfWorkRating;
  final Rating availabilityRating;
  final Rating adherenceToScheduleRating;
  final Rating communicationRating;
  final Rating cooperationRating;

  const FavoriteFreelancerEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.profilePicture,
      required this.skills,
      required this.expertise,
      required this.skillRating,
      required this.qualityOfWorkRating,
      required this.availabilityRating,
      required this.adherenceToScheduleRating,
      required this.communicationRating,
      required this.cooperationRating});

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
