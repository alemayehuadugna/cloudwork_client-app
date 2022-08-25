import 'package:flutter/material.dart';

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({
    Key? key,
    required TextEditingController newPasswordController,
  })  : _newPasswordController = newPasswordController,
        super(key: key);

  final TextEditingController _newPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "New Password",
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _newPasswordController,
          decoration: const InputDecoration(
            hintText: "New Password",
            hintMaxLines: 2, //hint text maximum lines
            hintTextDirection: TextDirection.ltr,
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null) {
              return "old password is required.";
            }
            return null;
          },
        ),
      ],
    );
  }
}
