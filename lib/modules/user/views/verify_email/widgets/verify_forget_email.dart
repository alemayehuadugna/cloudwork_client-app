import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/_shared/interface/bloc/auth/auth_bloc.dart';
import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/user/domain/entities/basic_user.dart';
import 'package:clean_flutter/modules/user/router.dart';
import 'package:clean_flutter/modules/user/views/verify_email/bloc/verify_email_bloc.dart';
import 'package:clean_flutter/modules/user/views/verify_email/cubit/useremail_cubit.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class VerifyForgotEmail extends StatelessWidget {
  VerifyForgotEmail({Key? key}) : super(key: key);

  final TextEditingController _inputOneController = TextEditingController();
  final TextEditingController _inputTwoController = TextEditingController();
  final TextEditingController _inputThreeController = TextEditingController();
  final TextEditingController _inputFourController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
      width: isMobile ? null : 448,
      decoration: isMobile
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              border: Border.all(
                width: 0.7,
                color: const Color(0xffdadce0),
              ),
            ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                child: SvgPicture.asset("assets/icons/new_email.svg"),
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Verify Your Email',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Please enter the OTP sent on your registered Email Address.',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_inputOneController, true),
                OtpInput(_inputTwoController, false),
                OtpInput(_inputThreeController, false),
                OtpInput(_inputFourController, false),
              ],
            ),
            VerifyButton(
              inputOneController: _inputOneController,
              inputTwoController: _inputTwoController,
              inputThreeController: _inputThreeController,
              inputFourController: _inputFourController,
              formKey: _formKey,
            ),
            // const ResendButton()
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remember Your Account?"),
                TextButton(
                  onPressed: () {
                    context.goNamed(loginRouteName);
                  },
                  child: const Text(
                    "Sign In",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
      child: BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
        listener: (context, state) {
          if (state is VerifyForgetEmailSuccess) {
            print("go");
            context.goNamed(resetPasswordRouteName);
          }
          if (state is VerifyEmailFailure) {
            showTopSnackBar(
              title: const Text("Error"),
              content: const Text(
                "Invalid Email, please enter again",
                overflow: TextOverflow.ellipsis,
              ),
              icon: const Icon(Icons.notifications_active_rounded),
              context: context,
            );
          }
        },
        builder: (context, state) {
          void _onSubmitted(String email) async {
            if (formKey.currentState!.validate()) {
              String otp =
                  '${inputOneController.text}${inputTwoController.text}${inputThreeController.text}${inputFourController.text}';

              final _verifyEmailBloc =
                  BlocProvider.of<VerifyEmailBloc>(context);

              _verifyEmailBloc
                  .add(VerifyForgetEmailEvent(code: otp, email: email));
            }
          }

          return BlocBuilder<UseremailCubit, String>(
            builder: ((context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    maximumSize:
                        MaterialStateProperty.all(const Size.fromHeight(51)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)))),
                onPressed: () {
                  _onSubmitted(state);
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
