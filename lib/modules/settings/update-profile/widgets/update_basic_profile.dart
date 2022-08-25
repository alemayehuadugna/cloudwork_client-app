import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/widgets/dialog_bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBasicProfileInfo extends StatelessWidget {
  const UpdateBasicProfileInfo(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.onSave})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  final void Function() onSave;
  @override
  Widget build(BuildContext context) {
    // bool isMobile = ResponsiveWrapper.of(context).isMobile;
    final _firstNameController = TextEditingController(text: firstName);
    final _phoneController = TextEditingController(text: phone);
    final _lastNameController = TextEditingController(text: lastName);
    final _emailController = TextEditingController(text: email);
    final _formKey = GlobalKey<FormState>();
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          onSave();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "First Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              hintMaxLines: 2, //hint text maximum lines
                              hintTextDirection: TextDirection.ltr,
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null) {
                                return "First Name is required.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Last Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Last Name",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null) {
                                return "Last Name is required.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Email",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null) {
                                return "Email is required.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Phone",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Phone Number",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFdadce0), width: 0.8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null) {
                                return "Phone is required.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                DialogBottomActions(
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<SettingBloc>(context).add(
                        UpdateBasicInfoEvent(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
