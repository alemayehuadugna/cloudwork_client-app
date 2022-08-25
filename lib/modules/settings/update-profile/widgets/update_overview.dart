import 'package:clean_flutter/modules/payments/views/widgets/dialog_bottom_actions.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileOverview extends StatelessWidget {
  const UpdateProfileOverview(
      {Key? key,
      required this.companyName,
      required this.websiteUrl,
      required this.onSave})
      : super(key: key);

  final String companyName;
  final String websiteUrl;

  final void Function() onSave;

  Widget build(BuildContext context) {
    final _companyNameController = TextEditingController(text: companyName);
    final _websiteUrlController = TextEditingController(text: websiteUrl);
    final _formKey = GlobalKey<FormState>();

    return BlocConsumer<SettingBloc, SettingState>(listener: (context, state) {
      if (state is UpdateProfileSuccess) {
        Navigator.of(context, rootNavigator: true).pop();
        onSave();
      }
    }, builder: ((context, state) {
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
                          "Company Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _companyNameController,
                          decoration: const InputDecoration(
                            hintText: "Company Name",
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
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "WebsiteUrl",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _websiteUrlController,
                          decoration: const InputDecoration(
                            hintText: "Website",
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
                        UpdateOverviewEvent(
                            companyName: _companyNameController.text,
                            websiteUrl: _websiteUrlController.text));
                  }
                },
              )
            ],
          ),
        ),
      );
    }));
  }
}
