import 'package:clean_flutter/modules/review/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_shared/interface/layout/navigation/navigation.dart';
import '../../modules/alerts/router.dart';
import '../../modules/favorites/router.dart';
import '../../modules/freelancer/router.dart';
import '../../modules/payments/router.dart';
import '../../modules/settings/router.dart';
import 'go_router.dart';

void navRoutes(int index, BuildContext context) {
  switch (NavigationTab.values[index]) {
    case NavigationTab.home:
      context.goNamed(homeRouteName);
      break;
    case NavigationTab.freelancer:
      context.goNamed(freelancersRouteName);
      break;
    case NavigationTab.jobs:
      context.go('/jobs');
      break;
    case NavigationTab.chat:
      context.goNamed(chatRouteName);
      break;
    case NavigationTab.setting:
      context.goNamed(profileSettingRouteName);
      break;
    case NavigationTab.wallet:
      context.goNamed(paymentRouteName);
      break;
    case NavigationTab.favorite:
      context.goNamed(favoriteRouteName);
      break;
    case NavigationTab.alert:
      context.goNamed(alertRouteName);
      break;
    case NavigationTab.review:
      context.goNamed(reviewRouteName);
      break;
    default:
  }
}
