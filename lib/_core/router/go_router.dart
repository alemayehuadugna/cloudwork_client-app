import 'package:clean_flutter/modules/chat/router.dart';
import 'package:clean_flutter/modules/dashboard/router.dart';
import 'package:clean_flutter/modules/favorites/router.dart';
import 'package:clean_flutter/modules/freelancer/router.dart';
import 'package:clean_flutter/modules/landing/pages/landing_page.dart';
import 'package:clean_flutter/modules/payments/router.dart';
import 'package:clean_flutter/modules/review/router.dart';
import 'package:clean_flutter/modules/settings/router.dart';
import 'package:clean_flutter/modules/client-job/router.dart';
import 'package:clean_flutter/modules/user/views/verify_email/pages/reset_password_page.dart';
import 'package:clean_flutter/modules/user/views/verify_email/pages/verify_email_page.dart';
import 'package:clean_flutter/modules/user/views/verify_email/pages/verify_forget_email_page.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/email_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';
import '../../_shared/interface/pages/error/error_page.dart';
import '../../_shared/interface/pages/loading/pages/loading_page.dart';
import '../../_shared/interface/pages/posts/posts_page.dart';
import '../../_shared/interface/pages/posts/single_post_page.dart';
import '../../modules/alerts/router.dart';
import '../../modules/user/router.dart';
import 'transitions.dart';

const fadeTransitionKey = ValueKey<String>('Fade Transition Page Key');
const layoutPageKey = ValueKey<String>('Layout Page Key');

const String rootRouteName = 'root';
const String loadingRouteName = 'loading';
const String homeRouteName = 'home';
const String chatRouteName = 'chat';
// const String favoriteRouteName = 'favorite';
const String verifyRouteName = 'verify';
const String forgetRouteName = 'forget-password';
const String verifyOtpForgetPassword = 'verify-forget-password';
const String resetPasswordRouteName = 'reset-password';

//! example page
const String postRouteName = 'post';
const String postDetailsRouteName = 'post-details';
const String landingRouteName = 'landing';

class GoAppRouter {
  final AuthBloc authBloc;

  GoAppRouter(this.authBloc);

  late final router = GoRouter(
      routes: [
        GoRoute(
          name: rootRouteName,
          path: '/',
          redirect: (_) => '/landing',
        ),
        GoRoute(
          name: loadingRouteName,
          path: '/loading',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoadingPage(),
          ),
        ),
        GoRoute(
            name: verifyRouteName,
            path: '/verify',
            pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: const VerifyEmailPage(),
                )),
        GoRoute(
            name: verifyOtpForgetPassword,
            path: '/verify-forget-password',
            pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: const VerifyForgetEmailPage(),
                )),
        GoRoute(
          name: postRouteName,
          path: '/post',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: fadeTransitionKey,
            child: LayoutPage(
              key: layoutPageKey,
              selectedTab: NavigationTab.chat,
              child: PostsPage(),
            ),
          ),
          routes: [
            GoRoute(
              name: postDetailsRouteName,
              path: 'details/:post',
              pageBuilder: (context, state) => FadeTransitionPage(
                key: state.pageKey,
                child: LayoutPage(
                  key: layoutPageKey,
                  selectedTab: NavigationTab.chat,
                  child: SinglePostPage(postId: state.params['post']),
                  hideBottomAndTopBarOnMobile: true,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          name: landingRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: const LandingPage(),
          ),
          path: '/landing',
        ),
        GoRoute(
          name: resetPasswordRouteName,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: const ResetPasswordPage(),
          ),
          path: '/reset-password',
        ),
        GoRoute(
            name: forgetRouteName,
            pageBuilder: ((context, state) =>
                FadeTransitionPage(key: state.pageKey, child: EmailInput())),
            path: '/forget-password'),
        ...homeRoutes,
        ...userRoutes,
        ...jobRoutes,
        ...profileSettingRoutes,
        ...favoritesRoutes,
        ...freelancerRoutes,
        ...paymentRoutes,
        ...chatRoutes,
        ...alertRoutes,
        ...reviewRoutes,
      ],
      errorPageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: ErrorPage(error: state.error),
          ),
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      debugLogDiagnostics: true,
      redirect: _guard);

  final unAuthScope = [
    '/login',
    '/create-account',
    '/forget-password',
    '/register',
    '/landing',
    '/verify',
    '/verify-forget-password',
    '/reset-password'
  ];

  String? _guard(GoRouterState state) {
    // final authLoading = authBloc.state is AuthLoading;

    // final isLoading = state.subloc == '/loading';
    // final loadingLoc = state.namedLocation(loadingRouteName);
    // if (authLoading) return isLoading ? null : loadingLoc;;

    final verifying = state.subloc == '/verify';
    final isUnverified = authBloc.state is Unverified;
    final verifyLoc = state.namedLocation(verifyRouteName);
    if (isUnverified) return verifying ? null : verifyLoc;

    final isUnauthenticated = authBloc.state is Unauthenticated;
    final unAuthRoute = unAuthScope.contains(state.subloc);
    final loggingIn = state.subloc == '/login';
    final loginLoc = state.namedLocation(loginRouteName);
    if (isUnauthenticated && !loggingIn) return unAuthRoute ? null : loginLoc;

    final loggedIn = authBloc.state is Authenticated;
    final rootLoc = state.namedLocation(homeRouteName);
    if (loggedIn && (loggingIn || unAuthRoute || verifying)) {
      return rootLoc;
    }
    return null;
  }
}
