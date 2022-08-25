import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/rating.dart';
import 'package:clean_flutter/modules/freelancer/data/models/json/freelancer_basic_remote_model.dart';

import '../../domain/entities/freelancer_basic.dart';

class FreelancerBasicMapper {
  static List<FreelancerBasic> fromJson(dynamic json) {
    var freelancers = <FreelancerBasic>[];
    try {
      json.forEach((e) {
        var temp = FreelancerBasicRemoteModel.fromJson(e);
        freelancers.add(FreelancerBasic(
            id: temp.id,
            firstName: temp.firstName,
            lastName: temp.lastName,
            expertise: temp.expertise,
            address: Address(
              temp.address.region,
              temp.address.city,
              temp.address.areaName,
              temp.address.postalCode,
            ),
            rating: Rating(
              temp.skillRating.rate,
              temp.skillRating.totalRate,
              temp.skillRating.totalRaters,
            ),
            skills: temp.skills,
            profilePicture: temp.profilePicture,
            gender: temp.gender,
            isVerified: temp.isVerified));
      });
    } catch (e) {
      print("FreelancerBasicMapper: Error> $e");
    }
    return freelancers;
  }
}
