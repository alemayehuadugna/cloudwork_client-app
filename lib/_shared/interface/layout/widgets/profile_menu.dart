import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/settings/router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/setting/theme_mode_cubit.dart';

class ProfilePopupMenu extends StatelessWidget {
  const ProfilePopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              var currentUser = authState.user;

              return PopupMenuButton(
                offset: const Offset(0, 50),
                iconSize: 30,
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: currentUser.profilePicture == 'profile_image_url'
                          ? const AssetImage(
                                  'assets/images/logo_placeholder.jpg')
                              as ImageProvider
                          : NetworkImage(currentUser.profilePicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      enabled: false, // DISABLED THIS ITEM
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const ProfileCard(),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: double.infinity,
                                  child: DropdownSearch<String>(
                                    selectedItem: state == ThemeModeState.dark
                                        ? "Dark"
                                        : ThemeModeState.light == state
                                            ? "Light"
                                            : "System",
                                    popupProps: const PopupProps.menu(
                                      menuProps: MenuProps(
                                        constraints:
                                            BoxConstraints(maxHeight: 145),
                                      ),
                                    ),
                                    items: const [
                                      "System",
                                      "Dark",
                                      "Light",
                                    ],
                                    onChanged: (String? value) {
                                      switch (value!) {
                                        case "System":
                                          AdaptiveTheme.of(context).setSystem();
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .systemMode();
                                          break;
                                        case "Light":
                                          AdaptiveTheme.of(context).setLight();
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .lightMode();
                                          break;
                                        case "Dark":
                                          AdaptiveTheme.of(context).setDark();
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .darkMode();
                                          break;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const LogoutButton(),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ];
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 45)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      onPressed: () async {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(UserLoggedOut());
      },
      icon: const Icon(
        Icons.login,
        size: 18,
      ),
      label: const Text("Logout"),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(profileRouteName);
      },
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/profile.png'),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 5),
                  Text(
                    "John Doe",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "johndoe@gmail.com",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
