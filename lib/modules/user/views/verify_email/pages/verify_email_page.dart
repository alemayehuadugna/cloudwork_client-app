import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/verify_email_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/verify_email_bloc.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: BlocProvider(
          create: (context) => container<VerifyEmailBloc>(),
          child: const VerifyEmailForm(),
        ),
      ),
    );
  }
}
