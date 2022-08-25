import 'package:clean_flutter/_shared/interface/layout/widgets/cloudwork_logo.dart';
import 'package:clean_flutter/modules/user/router.dart';
import 'package:clean_flutter/modules/user/views/sign_up/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../bloc/register_bloc.dart';

class User {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  User(this.firstName, this.lastName, this.phone, this.email, this.password,
      this.confirmPassword);
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordVisible = false;
  String password = '';
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onPasswordChanged(value) {
    password = value;
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          showTopSnackBar(
              title: const Text('Registration Error'),
              content: Text(state.error),
              icon: const Icon(Icons.error),
              context: context);
        }
      },
      child: SingleChildScrollView(
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
                    'Sign Up',
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
                ResponsiveRowColumn(
                  columnSpacing: 24,
                  rowSpacing: 8,
                  layout: isMobile
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: FirstName(controller: _firstNameController),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: LastName(controller: _lastNameController),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                PhoneField(controller: _phoneController),
                const SizedBox(
                  height: 24,
                ),
                EmailField(controller: _emailController),
                const SizedBox(
                  height: 24,
                ),
                ResponsiveRowColumn(
                  columnSpacing: 24,
                  rowSpacing: 8,
                  layout: isMobile
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: PasswordField(
                        isPasswordVisible: _passwordVisible,
                        controller: _passwordController,
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      rowFlex: 1,
                      child: ConfirmPasswordField(
                        isPasswordVisible: _passwordVisible,
                        controller: _confirmPasswordController,
                        password: _passwordController.text,
                      ),
                    ),
                  ],
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
                SignUpButton(
                  formKey: _formKey,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  phoneController: _phoneController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have Account?"),
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
      ),
    );
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
    print(password);
    print(controller.text);
    return TextFormField(
      obscureText: !isPasswordVisible,
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val!, password),
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Confirm",
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
        labelText: "Password",
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

class EmailField extends StatelessWidget {
  EmailField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter a valid email address'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Email",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );
  }
}

class PhoneField extends StatelessWidget {
  PhoneField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone is required'),
    PhoneValidator(errorText: 'Enter a valid phone number'),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // initialValue: "+251",
      decoration: const InputDecoration(
        isDense: true,
        labelText: "Phone",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      keyboardType: TextInputType.phone,
      validator: phoneValidator,
    );
  }
}

class PhoneValidator extends TextFieldValidator {
  PhoneValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    return hasMatch(r'^([+]251)?(9[0-9]{8})$', value!);
  }
}

class LastName extends StatelessWidget {
  LastName({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Last Name is required'),
    MinLengthValidator(
      3,
      errorText: 'Last Name must be at least 3 character long',
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          isDense: true,
          labelText: "Last Name",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        validator: lastNameValidator);
  }
}

class FirstName extends StatelessWidget {
  FirstName({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  // firstNameValidator = MultiValidator()
  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First Name is required'),
    MinLengthValidator(
      3,
      errorText: 'First Name must be at least 3 character long',
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        labelText: "First Name",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: firstNameValidator,
    );
  }
}
