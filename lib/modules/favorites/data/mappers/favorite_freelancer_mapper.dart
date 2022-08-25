import 'package:clean_flutter/_shared/domain/entities/rating.dart';
import 'package:clean_flutter/modules/favorites/data/json/remote_favorite_freelancer.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';

import '../../../../_shared/domain/entities/address.dart';

class FavoriteFreelancerMapper {
  static FavoriteFreelancerEntity fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var favoriteFreelancer;

    try {
      print("ezh gebtual");
      print(json);
      favoriteFreelancer = RemoteFavoriteFreelancer.fromJson(json);
      print(favoriteFreelancer);
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }

    return FavoriteFreelancerEntity(
        id: favoriteFreelancer.id,
        firstName: favoriteFreelancer.firstName,
        lastName: favoriteFreelancer.lastName,
        address: Address(
          favoriteFreelancer.address.region,
          favoriteFreelancer.address.city,
          favoriteFreelancer.address.areaName ?? '',
          favoriteFreelancer.address.postalCode ?? '',
        ),
        profilePicture: favoriteFreelancer.profilePicture,
        skills: favoriteFreelancer.skills,
        expertise: favoriteFreelancer.expertise,
        skillRating: Rating(
            favoriteFreelancer.skillRating.rate,
            favoriteFreelancer.skillRating.totalRate,
            favoriteFreelancer.skillRating.totalRaters),
        qualityOfWorkRating: Rating(
            favoriteFreelancer.qualityOfWorkRating.rate,
            favoriteFreelancer.qualityOfWorkRating.totalRate,
            favoriteFreelancer.qualityOfWorkRating.totalRaters),
        availabilityRating: Rating(
            favoriteFreelancer.availabilityRating.rate,
            favoriteFreelancer.availabilityRating.totalRate,
            favoriteFreelancer.availabilityRating.totalRaters),
        adherenceToScheduleRating: Rating(
            favoriteFreelancer.adherenceToScheduleRating.rate,
            favoriteFreelancer.adherenceToScheduleRating.totalRate,
            favoriteFreelancer.adherenceToScheduleRating.totalRaters),
        communicationRating: Rating(
            favoriteFreelancer.communicationRating.rate,
            favoriteFreelancer.communicationRating.totalRate,
            favoriteFreelancer.communicationRating.totalRaters),
        cooperationRating: Rating(
            favoriteFreelancer.cooperationRating.rate,
            favoriteFreelancer.cooperationRating.totalRate,
            favoriteFreelancer.cooperationRating.totalRaters));
  }
}
