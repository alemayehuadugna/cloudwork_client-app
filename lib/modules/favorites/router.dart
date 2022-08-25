import 'package:clean_flutter/_core/router/transitions.dart';
import 'package:clean_flutter/_shared/interface/layout/layout_page.dart';
import 'package:clean_flutter/_shared/interface/layout/navigation/navigation.dart';
import 'package:clean_flutter/modules/client-job/router.dart';
import 'package:clean_flutter/modules/favorites/views/fovorites_list.dart';
import 'package:go_router/go_router.dart';

const String favoriteRouteName = 'favorites';

final favoritesRoutes = [
  GoRoute(
    path: '/favorites',
    name: favoriteRouteName,
    pageBuilder: (context, state) => FadeTransitionPage(
      key: layoutPageKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.favorite,
        child: FavoritesLists(),
      ),
    ),
  )
];
