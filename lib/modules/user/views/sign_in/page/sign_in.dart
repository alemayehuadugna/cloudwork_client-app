import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../profile/widgets/widgets.dart';
import '../bloc/login_bloc.dart';
import '../widgets/sign_in_display.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => container<LoginBloc>(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (((context, state) {
                if (state is Unauthenticated || state is AuthFailure) {
                  return const SignInDisplay();
                } else if (state is AuthLoading || state is LoginInitial) {
                  return const LoadingWidget();
                }
                return Container();
              })),
            )
          ],
        ),
      ),
    );
  }
}
