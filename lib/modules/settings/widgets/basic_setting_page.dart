import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/update_address.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/update_basic_profile.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/update_description.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/update_overview.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/update_social_links.dart';
import 'package:clean_flutter/modules/settings/update-profile/widgets/upload_profile_picture.dart';
import 'package:clean_flutter/modules/settings/widgets/error_display.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:clean_flutter/modules/user/views/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BasicSettingPage extends StatelessWidget {
  const BasicSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildBody());
  }

  MultiBlocProvider buildBody() {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => container<ProfileBloc>()),
          BlocProvider(create: (context) => container<SettingBloc>())
        ],
        child: Column(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileInitial) {
                BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());

                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProfileLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProfileLoaded) {
                return EditProfileDisplay(user: state.user);
              } else if (state is ErrorLoadingProfile) {
                return const EditProfileErrorDisplay();
              }

              return Container();
            }),
          ],
        ));
  }
}

class EditProfileDisplay extends StatelessWidget {
  const EditProfileDisplay({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  // final DetailUser user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is ErrorUpdatingProfile) {
          showTopSnackBar(
              title: const Text("Error"),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
        } else if (state is UpdateProfileSuccess) {
          BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  TopCardTile(user: user),
                  const Divider(),
                  DescriptionCardTile(user: user),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProfileDescriptionCardTile(user: user),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SocialLinksCardTile(user: user),
          ),
        ],
      ),
    );
  }
}

class TopCardTile extends StatelessWidget {
  const TopCardTile({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ResponsiveRowColumn(
        rowSpacing: 20,
        columnSpacing: 15,
        layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    backgroundImage: user.profilePicture == "profile_image_url"
                        ? const NetworkImage('assets/images/user.png')
                        : NetworkImage(user.profilePicture),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -25,
                    child: RawMaterialButton(
                      onPressed: () {
                        // here pop up the dialog
                        ResponsiveWrapper.of(context).isMobile
                            ? _showGeneralDialog(
                                context,
                                UploadProfilePicture(
                                  imageUrl:
                                      user.profilePicture == "profile_image_url"
                                          ? 'assets/images/user.png'
                                          : user.profilePicture,
                                  fileUploadSuccess: onSave,
                                ),
                                "Change Profile",
                              )
                            : _showDialog(
                                context,
                                UploadProfilePicture(
                                  imageUrl:
                                      user.profilePicture == "profile_image_url"
                                          ? 'assets/images/user.png'
                                          : user.profilePicture,
                                  fileUploadSuccess: onSave,
                                ),
                                "Change Profile",
                              );
                      },
                      elevation: 1.0,
                      fillColor: Theme.of(context).colorScheme.background,
                      child: const Icon(Icons.edit),
                      padding: const EdgeInsets.all(10.0),
                      shape: const CircleBorder(),
                    ),
                  )
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
              child: Column(
            crossAxisAlignment:
                ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7)),
                  ),
                  RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 30, maxWidth: 30),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              UpdateBasicProfileInfo(
                                firstName: user.firstName,
                                lastName: user.lastName,
                                email: user.email,
                                phone: user.phone,
                                onSave: onSave,
                              ),
                              "Edit Basic Infos",
                            )
                          : _showDialog(
                              context,
                              UpdateBasicProfileInfo(
                                firstName: user.firstName,
                                lastName: user.lastName,
                                email: user.email,
                                phone: user.phone,
                                onSave: onSave,
                              ),
                              "Edit Basic Infos",
                            );
                    },
                    elevation: 1.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.edit, size: 20),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  )
                ],
              ),
              Row(
                children: [
                  Text(user.address != null
                      ? "${user.address!.city}, ${user.address!.region}"
                      : "Please set your address"),
                  RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 30, maxWidth: 30),
                    onPressed: () {
                      print("whta tthe fuck");
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              UpdateAddress(
                                  address: user.address == null
                                      ? new Address("", "", "", "")
                                      : user.address!,
                                  onSave: onSave),
                              "Update Address")
                          : _showDialog(
                              context,
                              UpdateAddress(
                                  address: user.address == null
                                      ? new Address("", "", "", "")
                                      : user.address!,
                                  onSave: onSave),
                              "Update Address");
                    },
                    elevation: 1.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.edit, size: 20),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  )
                ],
              ),
              const SizedBox(height: 5),
            ],
          ))
        ],
      ),
    );
  }
}

class ProfileDescriptionCardTile extends StatelessWidget {
  const ProfileDescriptionCardTile({Key? key, required this.user})
      : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Profile Overview",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 36, maxWidth: 36),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              UpdateProfileOverview(
                                  companyName: user.companyName,
                                  websiteUrl: user.websiteUrl,
                                  onSave: onSave),
                              "Update Profile Overview")
                          : _showDialog(
                              context,
                              UpdateProfileOverview(
                                  companyName: user.companyName,
                                  websiteUrl: user.websiteUrl,
                                  onSave: onSave),
                              "Update Profile Overview");
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.edit, size: 26),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                )
              ],
            ),
          ),
          // const Divider(),

          SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  OverviewTileItem(
                      title: "Company Name", subTitle: user.companyName),
                  const SizedBox(height: 15),
                  OverviewTileItem(title: "Email", subTitle: user.email),
                  const SizedBox(height: 15),
                  OverviewTileItem(
                      title: "Website Url", subTitle: user.websiteUrl),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DescriptionCardTile extends StatelessWidget {
  const DescriptionCardTile({Key? key, required this.user}) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  child: Text(
                    "Bio",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7)),
                  ),
                ),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  ResponsiveWrapper.of(context).isMobile
                      ? _showGeneralDialog(
                          context,
                          UpdateDescription(
                            description: user.description,
                            onSave: onSave,
                          ),
                          "Update Description",
                        )
                      : _showDialog(
                          context,
                          UpdateDescription(
                            description: user.description,
                            onSave: onSave,
                          ),
                          "Update Description",
                        );
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.edit, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    user.description != ''
                        ? user.description
                        : "Please Describe your self",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialLinksCardTile extends StatelessWidget {
  const SocialLinksCardTile({Key? key, required this.user}) : super(key: key);

  final DetailUser user;
  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Social Links",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 36, maxWidth: 36),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              UpdateSocialLinks(
                                  socialLinks: user.socialLinks,
                                  onSave: onSave),
                              "Update Social links")
                          : _showDialog(
                              context,
                              UpdateSocialLinks(
                                  socialLinks: user.socialLinks,
                                  onSave: onSave),
                              "Update Social links");
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.edit, size: 26),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
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
          )
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context, Widget body, String title) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => container<SettingBloc>(),
          child: Dialog(
            child: SizedBox(
              height: 600,
              width: 750,
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    title: Text(
                      title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    leading: IconButton(
                      color: Theme.of(context).colorScheme.onBackground,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close),
                    )),
                body: body,
              ),
            ),
          ),
        );
      });
}

void _showGeneralDialog(BuildContext context, Widget body, String title) {
  showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (context, anim, anis) {
        return SafeArea(
          child: SizedBox.expand(
            child: BlocProvider(
              create: (context) => container<SettingBloc>(),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close)),
                ),
                body: body,
              ),
            ),
          ),
        );
      });
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
