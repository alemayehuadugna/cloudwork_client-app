import 'package:flutter/material.dart';

import '../../../domain/entities/freelancer_basic.dart';

class ImageHolder extends StatefulWidget {
  const ImageHolder({
    Key? key,
    required this.freelancer,
  }) : super(key: key);

  final FreelancerBasic freelancer;

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  var imgVariable;

  @override
  void initState() {
    super.initState();
    imgVariable = NetworkImage(widget.freelancer.profilePicture);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          onError: (exception, stackTrace) {
            setState(() {
              if (widget.freelancer.gender == 'Male') {
                imgVariable =
                    const AssetImage('assets/images/men_profile_avatar.png');
              } else {
                imgVariable =
                    const AssetImage('assets/images/women_profile_avatar.jpg');
              }
            });
          },
          image: FadeInImage(
            placeholder:
                const AssetImage("assets/images/placeholder_image.png"),
            imageErrorBuilder: (context, error, stackTrace) {
              return Container();
            },
            image: imgVariable,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
