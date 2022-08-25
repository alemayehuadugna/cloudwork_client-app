import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  const ConfirmPasswordFormField({
    Key? key,
    required TextEditingController confirmPasswordController,
  })  : _confirmPasswordController = confirmPasswordController,
        super(key: key);

  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Confirm Password",
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: const InputDecoration(
            hintText: "Confirm Password",
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
