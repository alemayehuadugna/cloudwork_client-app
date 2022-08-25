import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../_core/router/go_router.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/error_text.svg",
          height: 320,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
            ),
          ),
          onPressed: () {
            context.goNamed(homeRouteName);
          },
          child: Text("Back To Home".toUpperCase()),
        )
      ],
    );
  }
}
