import 'package:flutter/material.dart';

class OldPasswordFormField extends StatelessWidget {
  const OldPasswordFormField({
    Key? key,
    required TextEditingController oldPasswordController,
  })  : _oldPasswordController = oldPasswordController,
        super(key: key);

  final TextEditingController _oldPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Old Password",
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _oldPasswordController,
          decoration: const InputDecoration(
            hintText: "Old Password",
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
