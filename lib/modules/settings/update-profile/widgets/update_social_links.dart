import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/payments/views/widgets/dialog_bottom_actions.dart';
import 'package:flutter/material.dart';

class UpdateSocialLinks extends StatelessWidget {
  UpdateSocialLinks({Key? key, required this.socialLinks, required this.onSave})
      : super(key: key);

  final List<SocialLink> socialLinks;

  final void Function() onSave;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _facebookLinkController = TextEditingController();
    final _twitterLinkController = TextEditingController();
    final _linkedinController = TextEditingController();
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
                        "Facebook Link",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _facebookLinkController,
                        decoration: const InputDecoration(
                          hintText: "Facebook Link",
                          hintMaxLines: 2, //hint text maximum lines
                          hintTextDirection: TextDirection.ltr,
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                        "Twitter Link",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _twitterLinkController,
                        decoration: const InputDecoration(
                          hintText: "Twitter Link",
                          hintMaxLines: 2, //hint text maximum lines
                          hintTextDirection: TextDirection.ltr,
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                        "Linkedin Link",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _linkedinController,
                        decoration: const InputDecoration(
                          hintText: "Linkedin Link",
                          hintMaxLines: 2, //hint text maximum lines
                          hintTextDirection: TextDirection.ltr,
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            DialogBottomActions(
              onSave: () {},
            )
          ],
        ),
      ),
    );
  }
}
