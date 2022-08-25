import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/_core/router/transitions.dart';
import 'package:clean_flutter/_shared/interface/layout/layout_page.dart';
import 'package:clean_flutter/_shared/interface/layout/navigation/navigation.dart';
import 'package:clean_flutter/modules/settings/views/setting_page.dart';
import 'package:clean_flutter/modules/settings/widgets/basic_setting_page.dart';
import 'package:clean_flutter/modules/settings/widgets/change_password_page.dart';
import 'package:clean_flutter/modules/settings/widgets/delete_account/delete_account_form.dart';
import 'package:clean_flutter/modules/settings/widgets/feedback/feedback_page.dart';
import 'package:clean_flutter/modules/user/views/profile/pages/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

const String profileSettingRouteName = 'profile-settings';
const String profileRouteName = 'profile';
const String editProfileRouteName = 'edit-profile';
const String changePasswordRouteName = 'change-password';
const String deleteAccountRouteName = 'delete-account';
const String feedbackRouteName = 'feedback';

final profileSettingRoutes = [
  GoRoute(
      path: '/profile-settings',
      name: profileSettingRouteName,
      pageBuilder: (context, state) => FadeTransitionPage(
            key: fadeTransitionKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const SettingMobilePage()
                  : const SettingPage(),
            ),
          ),
      routes: [
        GoRoute(
          path: 'profile',
          name: profileRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(body: ProfilePage())
                  : const ViewSetting(
                      body: ProfilePage(),
                    ),
            ),
          ),
        ),
        GoRoute(
          path: 'edit-profile',
          name: editProfileRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(
                      body: BasicSettingPage(),
                    )
                  : const ViewSetting(
                      body: BasicSettingPage(),
                    ),
            ),
          ),
        ),
        GoRoute(
          path: 'change-password',
          name: changePasswordRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? const ViewSettingMobile(
                      body: ChangePasswordPage(),
                    )
                  : const ViewSetting(
                      body: ChangePasswordPage(),
                    ),
            ),
          ),
        ),
        GoRoute(
          path: 'delete-account',
          name: deleteAccountRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? ViewSettingMobile(
                      body: DeleteAccountPage(),
                    )
                  : ViewSetting(
                      body: DeleteAccountPage(),
                    ),
            ),
          ),
        ),
        GoRoute(
          path: 'feedback',
          name: feedbackRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: LayoutPage(
              selectedTab: NavigationTab.setting,
              child: ResponsiveWrapper.of(context).isMobile
                  ? ViewSettingMobile(
                      body: FeedbackPage(),
                    )
                  : ViewSetting(
                      body: FeedbackPage(),
                    ),
            ),
          ),
        )
      ]),
];
