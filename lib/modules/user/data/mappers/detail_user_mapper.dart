import 'package:clean_flutter/_shared/data/models/hive/common_model.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/rating.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/user/data/hive/detail_local_user.dart';
import 'package:clean_flutter/modules/user/data/json/detail_remote_user.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';

class DetailUserMapper {
  static DetailLocalUser toModel(DetailUser user) {
    List<SocialLinkModel> socialLinks = [];
    socialLinks.addAll(user.socialLinks.map((socialLink) =>
        SocialLinkModel(socialLink.socialMedia, socialLink.link)));

    List<FavoriteModel> favorites = [];
    favorites
        .addAll(user.favorites.map((fav) => FavoriteModel(fav.freelancerId)));

    RatingModel rating = RatingModel(
        user.rating.rate, user.rating.totalRate, user.rating.totalRaters);

    return DetailLocalUser(
        user.id,
        user.firstName,
        user.lastName,
        user.userName,
        user.phone,
        user.description,
        user.email,
        user.roles,
        user.verified,
        user.profilePicture,
        user.isEmailVerified,
        socialLinks,
        favorites,
        rating,
        user.profileUrl,
        user.completedJobs,
        user.ongoingJobs,
        user.cancelledJobs,
        user.isProfileCompleted,
        user.profileCompletedPercentage,
        user.spending,
        user.address != null
            ? AddressModel(
                user.address!.region,
                user.address!.city,
                user.address?.areaName,
                user.address?.postalCode,
              )
            : null,
        user.workCategory,
        user.createdAt,
        user.websiteUrl,
        user.companyName);
  }

  static DetailUser fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var detailUser;
    List<SocialLink> socialLinks = [];
    List<Favorite> favorites = [];

    try {
      detailUser = DetailRemoteUser.fromJson(json);
      if (detailUser.socialLinks.length > 0) {
        print("social links alu");
        detailUser.socialLinks.forEach((socialLink) {
          socialLinks.add(SocialLink(socialLink.socialMedia, socialLink.link));
        });
        print(detailUser);
      }

      // print()
      if (detailUser.favorites.length > 0) {
        detailUser.favorites.forEach((fav) {
          favorites.add(Favorite(fav.freelancerId));
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    var user;
    try {
      user = DetailUser(
          detailUser.address != null
              ? Address(
                  detailUser.address.region,
                  detailUser.address.city,
                  detailUser.address.areaName,
                  detailUser.address.postalCode,
                )
              : null,
          id: detailUser.id,
          firstName: detailUser.firstName,
          lastName: detailUser.lastName,
          userName: detailUser.userName,
          phone: detailUser.phone,
          email: detailUser.email,
          description: detailUser.description,
          websiteUrl: detailUser.websiteUrl,
          companyName: detailUser.companyName,
          workCategory: detailUser.workCategory,
          verified: detailUser.verified,
          isEmailVerified: detailUser.isEmailVerified,
          profilePicture: detailUser.profilePicture,
          rating: Rating(detailUser.rating.rate, detailUser.rating.totalRate,
              detailUser.rating.totalRaters),
          roles: detailUser.roles,
          profileUrl: detailUser.profileUrl,
          completedJobs: detailUser.completedJobs,
          ongoingJobs: detailUser.ongoingJobs,
          cancelledJobs: detailUser.cancelledJobs,
          isProfileCompleted: detailUser.isProfileCompleted,
          profileCompletedPercentage: detailUser.profileCompletedPercentage,
          spending: detailUser.spending,
          createdAt: detailUser.createdAt,
          socialLinks: socialLinks,
          favorites: favorites);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
    return user;
  }
}
