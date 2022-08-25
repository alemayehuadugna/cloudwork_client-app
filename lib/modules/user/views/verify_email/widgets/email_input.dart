import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/modules/user/router.dart';
import 'package:clean_flutter/modules/user/views/verify_email/bloc/verify_email_bloc.dart';
import 'package:clean_flutter/modules/user/views/verify_email/cubit/useremail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class EmailInput extends StatelessWidget {
  EmailInput({Key? key}) : super(key: key);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocProvider(
      create: (context) => container<VerifyEmailBloc>(),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Container(
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
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
                    child: Text(
                      'Please enter your Email to reset your password.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFdadce0), width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFdadce0), width: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SendEmailButton(
                    controller: _emailController,
                    formKey: _formKey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Remember your password?"),
                      TextButton(
                          onPressed: () {
                            context.goNamed(loginRouteName);
                          },
                          child: const Text("Sign In"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SendEmailButton extends StatelessWidget {
  SendEmailButton({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<UseremailCubit>(context).setEmail(controller.text);
        final _sendVerifyBloc = BlocProvider.of<VerifyEmailBloc>(context);
        _sendVerifyBloc
            .add(ResendOTPRequested(email: controller.text, type: "Forget"));
      }
    }

    return BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
      listener: (context, state) {
        if (state is ResendOTPSuccess) {
          context.goNamed(verifyOtpForgetPassword);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ElevatedButton(
            onPressed: state is ResendOTPLoading ? null : onPressed,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size.fromHeight(52),
              ),
            ),
            child: const Text("Send"),
          ),
        );
      },
    );
  }
}
