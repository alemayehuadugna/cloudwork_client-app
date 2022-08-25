import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clean_flutter/modules/user/views/verify_email/cubit/useremail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '_core/di/get_It.dart';
import '_core/router/go_router.dart';
import '_core/theme/app_theme.dart';
import '_shared/interface/bloc/auth/auth_bloc.dart';
import '_shared/interface/bloc/setting/desktop_nav_cubit.dart';
import '_shared/interface/bloc/setting/theme_mode_cubit.dart';
import 'modules/alerts/views/bloc/list_alert_bloc/alert_bloc.dart';
import 'modules/alerts/views/bloc/new_alert_bloc/new_alert_bloc.dart';
import 'modules/chat/views/bloc/conversation_bloc/conversation_bloc.dart';
import 'modules/chat/views/bloc/message_bloc/message_bloc.dart';
import 'modules/chat/views/bloc/selected_conversation/selected_conversation_cubit.dart';
import 'modules/freelancer/common/bloc/filter_freelancer_menu_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(create: (context) => container()),
      BlocProvider<DesktopSideNavCubit>(create: (context) => container()),
      BlocProvider<ThemeModeCubit>(create: (context) => container()),
      BlocProvider<UseremailCubit>(
        create: (context) => container(),
      ),
      BlocProvider<ConversationBloc>(create: (context) => container()),
      BlocProvider<SelectedConversationCubit>(create: (context) => container()),
      BlocProvider<MessageBloc>(create: (context) => container()),
      BlocProvider<FilterFreelancerMenuCubit>(create: (context) => container()),
      BlocProvider<AlertBloc>(create: (context) => container()),
      BlocProvider<NewAlertBloc>(create: (context) => container()),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final goRouter = GoAppRouter(authBloc);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: ((context, state) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) => MaterialApp.router(
            theme: theme,
            darkTheme: darkTheme,
            title: "CloudWork Client",
            debugShowCheckedModeBanner: false,
            builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                defaultScale: true,
                minWidth: 360,
                defaultName: MOBILE,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(360),
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.resize(600, name: 'MOBILE_LARGE'),
                  ResponsiveBreakpoint.resize(850, name: TABLET),
                  ResponsiveBreakpoint.resize(1080, name: DESKTOP),
                ]),
            routerDelegate: goRouter.router.routerDelegate,
            routeInformationParser: goRouter.router.routeInformationParser,
          ),
        );
      }),
    );
  }
}
