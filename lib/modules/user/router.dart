import 'package:go_router/go_router.dart';
import '../../_core/router/transitions.dart';
import 'views/sign_in/page/sign_in.dart';
import 'views/sign_up/pages/sign_up_page.dart';

const String loginRouteName = 'login';
const String registerRouteName = 'register';

final userRoutes = [
  GoRoute(
    name: loginRouteName,
    path: '/login',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const SignInPage(),
    ),
  ),
  GoRoute(
    name: registerRouteName,
    path: '/register',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const SignUpPage(),
    ),
  ),
];
