import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_shared/interface/bloc/auth/auth_bloc.dart';
import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DeleteAccountPage extends StatelessWidget {
  DeleteAccountPage({Key? key}) : super(key: key);

  final _reasonField = TextEditingController();
  final _passwordField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocProvider(
      create: (context) => container<SettingBloc>(),
      child: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state is ErrorUpdatingProfile) {
            showTopSnackBar(
              title: Text(
                "Error",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 16,
                ),
              ),
              content: Text(state.message),
              icon: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
              context: context,
            );
          } else if (state is UpdateProfileSuccess) {
            BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
          }
        },
        builder: (context, state) {
          return Align(
            alignment: isMobile ? Alignment.topCenter : Alignment.center,
            child: SizedBox(
              width: isMobile ? double.infinity : 600,
              child: Container(
                decoration: isMobile
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            width: 0.7, color: const Color(0xffdadce0)),
                      ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:
                        isMobile ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      if (isMobile)
                        AppBar(
                          title: const Text("Delete Account"),
                          leading: const BackButton(),
                        ),
                      if (!isMobile)
                        SizedBox(
                          height: 56,
                          child: Center(
                            child: Text(
                              "Delete Account",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      const Divider(height: 0.5),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: 'Explanation is required'),
                              controller: _reasonField,
                              minLines: 5,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: "Please Explain Further**",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFdadce0), width: 0.8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFdadce0), width: 0.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: 'password is required'),
                              controller: _passwordField,
                              decoration: const InputDecoration(
                                label: Text("Password"),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFdadce0), width: 0.8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFdadce0), width: 0.8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                      if (isMobile) const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size.fromHeight(52),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<SettingBloc>(context).add(
                                  DeleteAccountEvent(
                                      _reasonField.text, _passwordField.text));
                            }
                            // showAlertDialog(context);
                          },
                          child: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  bool isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
  Widget cancelButton = TextButton(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        isLargerThanMobile
            ? const Size(double.infinity, 50)
            : const Size(double.infinity, 50),
      ),
    ),
    child: const Text("No"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete"),
    content: const Text("Are you sure?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
