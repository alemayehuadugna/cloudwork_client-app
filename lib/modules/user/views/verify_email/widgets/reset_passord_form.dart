import 'package:clean_flutter/_shared/interface/layout/widgets/cloudwork_logo.dart';
import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/user/router.dart';
import 'package:clean_flutter/modules/user/views/sign_up/bloc/register_bloc.dart';
import 'package:clean_flutter/modules/user/views/verify_email/cubit/useremail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool _passwordVisible = false;
  String password = '';
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showTopSnackBar(
            title: const Text("Success"),
            content: const Text(
              "You have reset your password Successfully ",
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(Icons.notifications_active_rounded),
            context: context,
          );
          context.goNamed(loginRouteName);
        }
        if (state is ErrorUpdatingProfile) {
          showTopSnackBar(
            title: const Text("Error"),
            content: const Text(
              "Error Occurred while you reset your password",
              overflow: TextOverflow.ellipsis,
            ),
            icon: const Icon(Icons.notifications_active_rounded),
            context: context,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
            width: isMobile ? null : 448,
            decoration: isMobile
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                    border:
                        Border.all(width: 0.7, color: const Color(0xffdadce0)),
                  ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CloudworkLogo(height: 60),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text(
                      'Reset Your Password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PasswordField(
                    isPasswordVisible: _passwordVisible,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConfirmPasswordField(
                    isPasswordVisible: _passwordVisible,
                    controller: _confirmPasswordController,
                    password: _passwordController.text,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _passwordVisible,
                        onChanged: (value) {
                          setState(() {
                            _passwordVisible = value ?? false;
                          });
                        },
                      ),
                      const Text("Show Password")
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeButton(
                    formKey: _formKey,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
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
          ),
        );
      },
    );
  }
}

class ChangeButton extends StatelessWidget {
  const ChangeButton(
      {Key? key, required this.formKey, required this.passwordController})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    void _onFormSubmitted(String email) async {
      print("email");
      print(email);
      if (formKey.currentState!.validate()) {
        final _settingBloc = BlocProvider.of<SettingBloc>(context);
        _settingBloc.add(ResetPasswordEvent(email, passwordController.text));
      }
    }

    return BlocBuilder<UseremailCubit, String>(builder: ((context, state) {
      return ElevatedButton(
        onPressed: () {
          _onFormSubmitted(state);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        child: const Text(
          "Change",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      );
    }));
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField(
      {Key? key,
      required this.isPasswordVisible,
      required this.controller,
      required this.password})
      : super(key: key);

  final bool isPasswordVisible;
  final TextEditingController controller;
  final String password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isPasswordVisible,
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val!, password),
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Confirm Password",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({
    Key? key,
    required this.isPasswordVisible,
    required this.controller,
  }) : super(key: key);

  final bool isPasswordVisible;
  final TextEditingController controller;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: passwordValidator,
      obscureText: !isPasswordVisible,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "New Password",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
