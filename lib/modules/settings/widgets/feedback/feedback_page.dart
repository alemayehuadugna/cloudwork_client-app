import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({Key? key}) : super(key: key);

  final _firsNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocProvider(
      create: (context) => container<SettingBloc>(),
      child: BlocListener<SettingBloc, SettingState>(
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
            _firsNameController.text = "";
            _lastNameController.text = "";
            _titleController.text = "";
            _messageController.text = "";
            showTopSnackBar(
              title: const Text(
                "Success",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              content: const Text("Thanks for your Feedback"),
              icon: const Icon(Icons.error, color: Colors.green),
              context: context,
            );
          }
        },
        child: BlocBuilder<SettingBloc, SettingState>(
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
                            width: 0.7,
                            color: const Color(0xffdadce0),
                          ),
                        ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize:
                          isMobile ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        if (isMobile)
                          AppBar(
                            title: const Text("Give Your Feedback"),
                            leading: const BackButton(),
                          ),
                        if (!isMobile)
                          SizedBox(
                            height: 56,
                            child: Center(
                              child: Text(
                                "Give Your Feedback",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        const Divider(
                          height: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _firsNameController,
                                validator: RequiredValidator(
                                    errorText: 'First Name is required'),
                                decoration: const InputDecoration(
                                  label: Text("First Name"),
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _lastNameController,
                                validator: RequiredValidator(
                                    errorText: 'Last Name is required'),
                                decoration: const InputDecoration(
                                  label: Text("Last Name"),
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _titleController,
                                validator: RequiredValidator(
                                    errorText: 'Title is required'),
                                decoration: const InputDecoration(
                                  label: Text("Title"),
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
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _messageController,
                                validator: RequiredValidator(
                                    errorText: 'Message is required'),
                                minLines: 5,
                                maxLines: 6,
                                decoration: const InputDecoration(
                                  label: Text("Message"),
                                  hintText: "Please Add you Feedback",
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
                                    FeedbackEvent(
                                        _firsNameController.text,
                                        _lastNameController.text,
                                        _messageController.text,
                                        _titleController.text));
                              }
                              // showAlertDialog(context);
                            },
                            child: const Text("Send"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
