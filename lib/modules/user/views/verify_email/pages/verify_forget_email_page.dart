import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/modules/user/views/verify_email/bloc/verify_email_bloc.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/verify_forget_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyForgetEmailPage extends StatelessWidget {
  const VerifyForgetEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: BlocProvider(
          create: (context) => container<VerifyEmailBloc>(),
          child: VerifyForgotEmail(),
        ),
      ),
    );
  }
}
