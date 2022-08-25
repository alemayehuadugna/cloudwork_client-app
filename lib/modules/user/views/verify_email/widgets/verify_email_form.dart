import 'package:clean_flutter/modules/user/views/verify_email/widgets/otp_input.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/resend_button.dart';
import 'package:clean_flutter/modules/user/views/verify_email/widgets/verify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({Key? key}) : super(key: key);

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputOneController = TextEditingController();
  final TextEditingController _inputTwoController = TextEditingController();
  final TextEditingController _inputThreeController = TextEditingController();
  final TextEditingController _inputFourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
      width: isMobile ? null : 448,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                child: SvgPicture.asset("assets/icons/new_email.svg"),
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Verify Your Email',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Please enter the OTP sent on your registered Email Address.',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_inputOneController, true),
                OtpInput(_inputTwoController, false),
                OtpInput(_inputThreeController, false),
                OtpInput(_inputFourController, false),
              ],
            ),
            VerifyButton(
              inputOneController: _inputOneController,
              inputTwoController: _inputTwoController,
              inputThreeController: _inputThreeController,
              inputFourController: _inputFourController,
              formKey: _formKey,
            ),
            const ResendButton()
          ],
        ),
      ),
    );
  }
}
