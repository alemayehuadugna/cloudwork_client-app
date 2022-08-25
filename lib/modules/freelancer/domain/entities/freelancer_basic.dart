import 'package:equatable/equatable.dart';

import '../../../../_shared/domain/entities/address.dart';
import '../../../../_shared/domain/entities/rating.dart';

class FreelancerBasic extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final Address address;
  final Rating rating;
  final String expertise;
  final List<String> skills;
  final String profilePicture;
  final String gender;
  final bool isVerified;

  const FreelancerBasic({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.rating,
    required this.expertise,
    required this.skills,
    required this.profilePicture,
    required this.gender,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        address,
        rating,
        skills,
        profilePicture,
        gender,
        isVerified,
      ];
}
