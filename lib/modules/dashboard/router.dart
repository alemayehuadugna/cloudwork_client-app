import 'package:go_router/go_router.dart';

import '../../_core/router/transitions.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/navigation.dart';
import '../client-job/router.dart';
import 'views/pages/dashboard_page.dart';

const String homeRouteName = 'home';

final List<GoRoute> homeRoutes = [
  GoRoute(
    name: homeRouteName,
    path: '/dashboard',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: layoutPageKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.home,
        child: DashboardPage(),
      ),
    ),
  )
];
