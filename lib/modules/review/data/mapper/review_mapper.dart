

import '../../domain/entities/review.dart';
import '../models/json/review_remote_model.dart';

class ReviewMapper {
  static List<Review> fromJson(dynamic json) {
    List<Review> reviews = [];
    json.forEach((e) {
      final temp = ReviewRemoteModel.fromJson(e);
      reviews.add(Review(temp.id,
          jobId: temp.jobId,
          reviewerId: temp.reviewerId,
          reviewedId: temp.reviewedId,
          title: temp.title,
          comment: temp.comment,
          rate: temp.rate,
          createdAt: temp.createdAt));
    });

    return reviews;
  }

  static toJson(Review review) {
    final data = ReviewRemoteModel(
      review.id,
      review.jobId,
      review.reviewerId,
      review.reviewedId,
      review.title,
      review.comment,
      review.rate,
      null,
    ).toJson();
    return data;
  }
}
