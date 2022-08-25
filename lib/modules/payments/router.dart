import 'package:clean_flutter/_core/router/transitions.dart';
import 'package:clean_flutter/_shared/interface/layout/layout_page.dart';
import 'package:clean_flutter/modules/payments/views/pages/payment_page.dart';
import 'package:go_router/go_router.dart';

import '../../_core/router/go_router.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';

const String paymentRouteName = 'payment';

final paymentRoutes = [
  GoRoute(
    name: paymentRouteName,
    path: '/payments',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: layoutPageKey,
      child: const LayoutPage(
        selectedTab: NavigationTab.wallet,
        child: PaymentPage(),
      ),
    ),
  ),
];
