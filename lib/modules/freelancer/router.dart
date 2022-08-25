import 'package:clean_flutter/_core/router/transitions.dart';
import 'package:clean_flutter/_shared/interface/layout/layout_page.dart';
import 'package:clean_flutter/_shared/interface/layout/navigation/navigation.dart';
import 'package:clean_flutter/modules/freelancer/views/detail/pages/freelancer_detail_page.dart';
import 'package:clean_flutter/modules/freelancer/views/list/pages/list_freelancers_page.dart';
import 'package:go_router/go_router.dart';

import '../../_core/router/go_router.dart';

const String freelancersRouteName = 'freelancers';
const String freelancerDetailRouteName = 'freelancerDetail';

final freelancerRoutes = [
  GoRoute(
      name: freelancersRouteName,
      path: '/freelancers',
      pageBuilder: (context, state) => FadeTransitionPage(
            key: fadeTransitionKey,
            child: const LayoutPage(
              key: layoutPageKey,
              selectedTab: NavigationTab.freelancer,
              child: ListFreelancersPage(),
            ),
          ),
      routes: [
        GoRoute(
            name: freelancerDetailRouteName,
            path: 'details/:freelancer',
            pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: LayoutPage(
                    key: layoutPageKey,
                    selectedTab: NavigationTab.freelancer,
                    child: FreelancerDetailPage(
                      id: state.params['freelancer'],
                    ),
                    hideBottomAndTopBarOnMobile: true,
                  ),
                ))
      ])
];
