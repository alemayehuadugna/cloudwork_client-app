import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/_shared/interface/layout/widgets/cloudwork_logo.dart';
import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/user/router.dart';
import 'package:clean_flutter/modules/user/views/sign_in/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Credentials {
  final String email;
  final String password;

  Credentials(this.email, this.password);
}

class SignInDisplay extends StatelessWidget {
  const SignInDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => container(),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  State<_SignInForm> createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  void changePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: ((context, state) {
        if (state is LoginFailure) {
          showTopSnackBar(
            title: Text(
              "Error",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
              ),
            ),
            content: Text(state.error),
            icon: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            context: context,
          );
        }
      }),
      builder: (context, state) {
        return Container(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CloudworkLogo(height: 60),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    'Sign In',
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
                // email field
                EmailInput(
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                PasswordInput(
                  passwordVisible: _passwordVisible,
                  controller: _passwordController,
                  changePasswordVisibility: changePasswordVisibility,
                ),
                ForgetPasswordButton(),
                const SizedBox(
                  height: 20,
                ),
                LoginButton(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 40,
                ),
                const SignUpButton()
              ],
            ),
          ),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t Have Account?'),
        TextButton(
          onPressed: () {
            context.goNamed(registerRouteName);
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  EmailInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: emailValidator,
      controller: controller,
      decoration: const InputDecoration(
        isDense: false,
        labelText: "Email",
        suffixIcon: Icon(Icons.email),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
    required this.passwordVisible,
    required this.controller,
    required this.changePasswordVisibility,
  }) : super(key: key);

  final TextEditingController controller;
  final bool passwordVisible;
  final Function changePasswordVisibility;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: passwordValidator,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        isDense: false,
        labelText: "Password",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            changePasswordVisibility();
          },
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      controller: controller,
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.goNamed(forgetRouteName);
          },
          child: const Text("Forget Password?"),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;

    void _onFormSubmitted() async {
      if (_formKey.currentState!.validate()) {
        var _loginBloc = BlocProvider.of<LoginBloc>(context);
        _loginBloc.add(LoginInSubmitted(
            email: _emailController.text, password: _passwordController.text));
      }
    }

    return ElevatedButton(
      onPressed: state is! LoginLoading ? _onFormSubmitted : null,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
      ),
      child: state is LoginLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            )
          : const Text(
              "Log In",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
    );
  }
}
