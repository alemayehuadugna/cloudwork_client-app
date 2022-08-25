import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCheckBox extends StatefulWidget {
  const RatingCheckBox({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  State<RatingCheckBox> createState() => _RatingCheckBoxState();
}

class _RatingCheckBoxState extends State<RatingCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          value: isChecked,
        ),
        RatingBar.builder(
          initialRating: widget.rating,
          // minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 20,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (double value) {},
        ),
        const SizedBox(width: 5),
        Text("(${widget.rating})")
      ],
    );
  }
}
