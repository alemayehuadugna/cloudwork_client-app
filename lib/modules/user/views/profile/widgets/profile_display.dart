import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:clean_flutter/modules/user/views/profile/widgets/profile_top_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTopCard(user: user),
        const SizedBox(
          height: 10,
        ),
        PageBody(user: user)
      ],
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    final isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return ResponsiveRowColumn(
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
      layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 4,
          child: Column(
            children: [
              CardTile(
                title: "About us",
                body:
                    Text(user.description != '' ? user.description : "not set"),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        ResponsiveRowColumnItem(
          rowFlex: 2,
          child: Column(
            children: [
              if (ResponsiveWrapper.of(context).isSmallerThan(TABLET))
                const SizedBox(height: 8),
              CardTile(
                title: 'Profile Overview',
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    OverviewTileItem(
                        title: "Company Name", subTitle: user.companyName),
                    const SizedBox(height: 15),
                    OverviewTileItem(
                        title: "Owner Name", subTitle: user.firstName),
                    OverviewTileItem(title: "Email", subTitle: user.email),
                    const SizedBox(height: 15),
                    OverviewTileItem(
                        title: "Website Url", subTitle: user.websiteUrl),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'SOCIAL LINKS',
                body: Column(
                  children: [
                    if (user.socialLinks.isNotEmpty)
                      for (var socLink in user.socialLinks)
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            socLink.link,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                    if (user.socialLinks.isEmpty)
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Not Set",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class OverviewTileItem extends StatelessWidget {
  const OverviewTileItem({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.6,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 16,
                ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(subTitle != '' ? subTitle! : "Please add your $title if you have?",
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
      ],
    );
  }
}

class SkillTile extends StatelessWidget {
  const SkillTile({Key? key, required this.skill}) : super(key: key);

  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).chipTheme.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 2, 7),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Text("+ " + skill),
      width: 195,
      height: 35,
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile({
    Key? key,
    required this.title,
    required this.body,
    this.editButton,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool? editButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: 40,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    required this.title,
    this.extent,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final int index;
  final double? extent;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: extent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(index.toString(),
                style: TextStyle(fontSize: 16, color: backgroundColor)),
            const SizedBox(width: 5),
            Text(title, style: const TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
