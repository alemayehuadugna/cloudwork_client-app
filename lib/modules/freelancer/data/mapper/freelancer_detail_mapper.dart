import '../../../../_shared/domain/entities/address.dart';
import '../../../../_shared/domain/entities/range_date.dart';
import '../../../../_shared/domain/entities/rating.dart';
import '../../domain/entities/freelancer_detail.dart';
import '../models/json/freelancer_detail_remote_model.dart';

class FreelancerDetailMapper {
  static FreelancerDetail fromJosn(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var user;
    List<SocialLink> socialLinks = [];
    List<Language> languages = [];
    List<Education> educations = [];
    List<Employment> employments = [];
    List<OtherExperience> otherExperiences = [];
    try {
      user = FreelancerDetailRemoteModel.fromJson(json);
      user.socialLinks.forEach((e) {
        socialLinks.add(SocialLink(e.socialMedia, e.link));
      });
      user.languages.forEach((e) {
        languages.add(Language(e.language, e.proficiencyLevel));
      });
      user.educations.forEach((edu) {
        educations.add(Education(
            edu.institution,
            RangeDate(edu.dateAttended.start, edu.dateAttended.end),
            edu.degree,
            edu.areaOfStudy,
            edu.description,
            id: edu.id));
      });

      user.employments.forEach((e) {
        employments.add(Employment(e.company, e.city, e.region, e.title,
            RangeDate(e.period.start, e.period.end), e.summary,
            id: e.id));
      });
      user.otherExperiences.forEach((e) {
        otherExperiences.add(OtherExperience(
          e.subject,
          e.description,
          id: e.id,
        ));
      });
    } catch (e) {
      // ignore: avoid_print
      print("in user mapper catch => $e");
    }

    final FreelancerDetail detailUser = FreelancerDetail(
      user.address != null
          ? Address(
              user.address.region,
              user.address.city,
              user.address.areaName,
              user.address.postalCode,
            )
          : null,
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      gender: user.gender,
      skills: user.skills,
      overview: user.overview,
      socialLinks: socialLinks,
      languages: languages,
      educations: educations,
      employments: employments,
      otherExperiences: otherExperiences,
      completedJobs: user.completedJobs,
      ongoingJobs: user.ongoingJobs,
      cancelledJobs: user.cancelledJobs,
      numberOfReviews: user.numberOfReviews,
      expertise: user.expertise,
      verified: user.verified,
      joinedDate: user.joinedDate,
      profilePicture: user.profilePicture,
      userName: user.userName,
      skillRating: Rating(
        user.skillRating.rate,
        user.skillRating.totalRate,
        user.skillRating.totalRaters,
      ),
      qualityOfWorkRating: Rating(
        user.qualityOfWorkRating.rate,
        user.qualityOfWorkRating.totalRate,
        user.qualityOfWorkRating.totalRaters,
      ),
      availabilityRating: Rating(
        user.availabilityRating.rate,
        user.availabilityRating.totalRate,
        user.availabilityRating.totalRaters,
      ),
      adherenceToScheduleRating: Rating(
        user.adherenceToScheduleRating.rate,
        user.adherenceToScheduleRating.totalRate,
        user.adherenceToScheduleRating.totalRaters,
      ),
      communicationRating: Rating(
        user.communicationRating.rate,
        user.communicationRating.totalRate,
        user.communicationRating.totalRaters,
      ),
      cooperationRating: Rating(
        user.cooperationRating.rate,
        user.cooperationRating.totalRate,
        user.cooperationRating.totalRaters,
      ),
      available: user.available,
    );
    return detailUser;
  }
}
