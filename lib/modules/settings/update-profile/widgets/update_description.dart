import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/widgets/dialog_bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _hintText = 'Describe your self or organization.';

class UpdateDescription extends StatelessWidget {
  final String description;

  final void Function() onSave;
  const UpdateDescription({
    Key? key,
    required this.description,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController? _descriptionField =
        TextEditingController(text: description);
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
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _descriptionField,
                    keyboardType: TextInputType.multiline,
                    minLines: 8,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintMaxLines: 8,
                      hintText: _hintText,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFdadce0), width: 0.6),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFdadce0), width: 0.6),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                DialogBottomActions(onSave: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<SettingBloc>(context).add(
                        UpdateDescriptionEvent(
                            description: _descriptionField.text));
                  }
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
