import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FreelancerCard extends StatelessWidget {
  const FreelancerCard({Key? key, required this.freelancer}) : super(key: key);

  final FavoriteFreelancerEntity freelancer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageHolder(),
                  SizedBox(
                    width: 15,
                  ),
                  InfoHolder(freelancer: freelancer)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.star_border,
                    color: Color(0XFFFF5B37),
                    size: 26,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0XFFff431a),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                    ),
                    child: const Text("View profile"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoHolder extends StatelessWidget {
  const InfoHolder({
    Key? key,
    required this.freelancer,
  }) : super(key: key);

  final FavoriteFreelancerEntity freelancer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          freelancer.firstName + " " + freelancer.lastName,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          freelancer.expertise,
          style: const TextStyle(
            // color: Color(0XFF6e727d),
            fontSize: 12,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              freelancer.address.city + ", " + freelancer.address.region,
              style: const TextStyle(
                // color: Color(0XFF6e727d),
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.location_on,
              // color: Color(0XFF6e727d),
              size: 18,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemSize: 15,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double value) {},
            ),
            const Text(
              "4.3",
              style: TextStyle(
                color: Color(0XFF6e727d),
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              "(32)",
              style: TextStyle(
                color: Color(0XFF6e727d),
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            for (var skill in freelancer.skills) ...[
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                child: Text(
                  skill,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
            ]
          ],
        )
      ],
    );
  }
}

class ImageHolder extends StatelessWidget {
  const ImageHolder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.0,
      height: 70.0,
      child: CircleAvatar(
        radius: 16.0,
        child: ClipRRect(
          child: Image.asset('assets/images/logo.png'),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
