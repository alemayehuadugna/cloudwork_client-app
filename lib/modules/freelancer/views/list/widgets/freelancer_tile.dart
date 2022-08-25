import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/freelancer_basic.dart';
import '../../../router.dart';
import 'image_holder.dart';

class FreelancerTile extends StatelessWidget {
  const FreelancerTile({
    Key? key,
    required this.freelancer,
  }) : super(key: key);

  final FreelancerBasic freelancer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0),
      child: Card(
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                child: Column(
                  children: [
                    ImageHolder(freelancer: freelancer),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${freelancer.firstName} ${freelancer.lastName}"
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.verified,
                          color: freelancer.isVerified
                              ? Colors.green
                              : Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7),
                          size: 30,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(freelancer.expertise),
                    const SizedBox(height: 5),
                    Text(
                        "${freelancer.address.city}, ${freelancer.address.region}"),
                    const SizedBox(height: 5),
                    RatingBar.builder(
                      initialRating: freelancer.rating.rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (int i = 0;
                            i < freelancer.skills.length && i < 6;
                            i++)
                          Container(
                            width: 80,
                            height: 26,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).chipTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                freelancer.skills[i],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  minimumSize:
                      MaterialStateProperty.all(const Size.fromHeight(50))),
              onPressed: () {
                context.goNamed(
                  freelancerDetailRouteName,
                  params: {'freelancer': freelancer.id},
                );
              },
              child: const Text("View Profile"),
            )
          ],
        ),
      ),
    );
  }
}
