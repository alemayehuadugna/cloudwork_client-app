import 'package:clean_flutter/_shared/interface/bloc/auth/auth_bloc.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/verify_email_bloc.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton(
      {Key? key,
      required this.formKey,
      required this.inputOneController,
      required this.inputTwoController,
      required this.inputThreeController,
      required this.inputFourController})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController inputOneController;
  final TextEditingController inputTwoController;
  final TextEditingController inputThreeController;
  final TextEditingController inputFourController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
      child: BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
          void _onSubmitted() async {
            if (formKey.currentState!.validate()) {
              final _authBloc = BlocProvider.of<AuthBloc>(context);
              final _verifyEmailBloc =
                  BlocProvider.of<VerifyEmailBloc>(context);

              String otp =
                  '${inputOneController.text}${inputTwoController.text}${inputThreeController.text}${inputFourController.text}';

              if (_authBloc.state is Unverified) {
                final BasicUser user = _authBloc.state.props[0] as BasicUser;
                _verifyEmailBloc
                    .add(VerifyEmailRequested(code: otp, email: user.email));
              }
            }
          }

          return ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                maximumSize:
                    MaterialStateProperty.all(const Size.fromHeight(51)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)))),
            onPressed: _onSubmitted,
            child: const Text(
              'Verify',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}
