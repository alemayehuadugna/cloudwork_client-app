import 'package:clean_flutter/_shared/interface/layout/widgets/cloudwork_icon.dart';
import 'package:flutter/material.dart';

import 'adaptive_navigation.dart';

enum NavigationTab {
  home,
  freelancer,
  jobs,
  chat,
  alert,
  favorite,
  wallet,
  review,
  setting,
}

final navItems = <AdaptiveDestination>[
  AdaptiveDestination(
    title: 'Home',
    icon: CloudworkIcon.cloudwork_icon,
  ),
  AdaptiveDestination(
    title: 'Freelancer',
    icon: Icons.people,
  ),
  AdaptiveDestination(
    title: 'Jobs',
    icon: Icons.work,
  ),
  AdaptiveDestination(
    title: 'Chat',
    icon: Icons.message,
  ),
  AdaptiveDestination(
    title: 'Alert',
    icon: Icons.notifications,
  ),
  AdaptiveDestination(
    title: 'Favorite',
    icon: Icons.favorite,
  ),
  AdaptiveDestination(
    title: 'Wallet',
    icon: Icons.account_balance_wallet,
  ),
  AdaptiveDestination(
    title: 'Review',
    icon: Icons.rate_review,
  ),
  AdaptiveDestination(
    title: 'Setting',
    icon: Icons.settings,
  ),
];
