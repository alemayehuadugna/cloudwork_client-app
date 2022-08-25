import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfileTopCard extends StatelessWidget {
  const ProfileTopCard({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    final isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: ResponsiveRowColumn(
        layout: isLargerThanMobile
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResponsiveRowColumnItem(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveRowColumn(
                  rowPadding: const EdgeInsets.all(10),
                  columnPadding: const EdgeInsets.all(10),
                  rowSpacing: 20,
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  layout: isLargerThanMobile
                      ? ResponsiveRowColumnType.ROW
                      : ResponsiveRowColumnType.COLUMN,
                  children: [
                    ResponsiveRowColumnItem(
                      child: Center(
                          child: Center(
                        child: ClipRRect(
                            child: user.profilePicture == "profile_image_url"
                                ? Image.asset(
                                    'assets/images/user.png',
                                    height: 160,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    user.profilePicture,
                                    height: 160,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  )),
                      )),
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        alignment: ResponsiveValue<Alignment>(context,
                                defaultValue: Alignment.center,
                                valueWhen: [
                                  const Condition.equals(
                                      name: MOBILE, value: Alignment.center),
                                  const Condition.largerThan(
                                      name: 'MOBILE_LARGE',
                                      value: Alignment.center),
                                ]).value ??
                            Alignment.center,
                        height:
                            ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                                ? null
                                : 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: isLargerThanMobile
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700)),
                                Icon(
                                  Icons.verified,
                                  color: user.verified
                                      ? Colors.green
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.7),
                                  size: 30,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'since July 2017',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            IntrinsicHeight(
                              child: ResponsiveRowColumn(
                                rowMainAxisAlignment: isLargerThanMobile
                                    ? MainAxisAlignment.spaceEvenly
                                    : MainAxisAlignment.center,
                                layout: ResponsiveRowColumnType.ROW,
                                children: [
                                  ResponsiveRowColumnItem(
                                    child: Text(user.address != null
                                        ? user.address!.city
                                        : "not set"),
                                  ),
                                  ResponsiveRowColumnItem(
                                      child: VerticalDivider(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    thickness: 1,
                                  )),
                                  ResponsiveRowColumnItem(
                                      child: Text(user.address != null
                                          ? "${user.address!.region},  Ethiopia"
                                          : "not set"))
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
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
                                Text("${user.rating.rate}"),
                                Text("(${user.rating.totalRate})")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
