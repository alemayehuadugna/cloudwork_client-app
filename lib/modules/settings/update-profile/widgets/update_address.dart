import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/widgets/dialog_bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAddress extends StatelessWidget {
  const UpdateAddress({Key? key, required this.address, required this.onSave})
      : super(key: key);

  final Address address;

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final _regionController =
        TextEditingController(text: address != null ? address.region : "");
    final _cityController =
        TextEditingController(text: address != null ? address.city : "");
    final _areaNameController =
        TextEditingController(text: address != null ? address.areaName : "");
    final _postalCodeController =
        TextEditingController(text: address.postalCode);
    final _formKey = GlobalKey<FormState>();

    return BlocConsumer<SettingBloc, SettingState>(listener: (context, state) {
      if (state is UpdateProfileSuccess) {
        Navigator.of(context, rootNavigator: true).pop();
        onSave();
      }
    }, builder: (context, state) {
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
                          "Region",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _regionController,
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "Region",
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
                              return "Region is required.";
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
                          "City",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "City",
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
                              return "City is required.";
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
                          "Area Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _areaNameController,
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "Area Name",
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
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Postal Code",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _postalCodeController,
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: "Postal Code",
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
                    var address = Address(
                        _regionController.text,
                        _cityController.text,
                        _areaNameController.text,
                        _postalCodeController.text);
                    BlocProvider.of<SettingBloc>(context)
                        .add(UpdateAddressEvent(address: address));
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
