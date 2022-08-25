import 'package:clean_flutter/_shared/interface/pages/widgets/show_top_flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../review/views/bloc/give_review_bloc/give_review_bloc.dart';
import 'dialog_bottom_actions.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({
    Key? key,
    required this.jobId,
    required this.reviewedId,
    required this.reviewerId,
  }) : super(key: key);

  final String jobId;
  final String reviewerId;
  final String reviewedId;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _titleField = TextEditingController();
    final _descriptionField = TextEditingController();
    double rate = 0;
    void giveRating(double rating) {
      String number = rating.toStringAsFixed(1);
      rate = double.parse(number);
    }

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.secondary,
          size: 50.0,
        ),
      ),
      overlayColor: Theme.of(context).colorScheme.primary,
      overlayOpacity: 0.2,
      child: BlocListener<GiveReviewBloc, GiveReviewState>(
        listener: (context, state) {
          if (state is GiveReviewError) {
            showTopSnackBar(
              title: const Text("Error"),
              content: Text(state.message),
              icon: const Icon(
                Icons.error,
              ),
              context: context,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleField,
                        // validator: validator,
                        decoration: const InputDecoration(
                          isDense: true,
                          label: Text('Title'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: null,
                        validator: RequiredValidator(
                            errorText: 'Description required'),
                        controller: _descriptionField,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFdadce0), width: 0.6),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        "Ratings",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      RatingSlider(
                        giveRating: giveRating,
                        rate: 0,
                      ),
                    ],
                  ),
                )),
                DialogBottomActions(
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<GiveReviewBloc>(context).add(
                        WriteReviewEvent(jobId, reviewedId, reviewerId,
                            _titleField.text, _descriptionField.text, rate),
                      );
                    }
                  },
                  label: "Submit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingSlider extends StatefulWidget {
  const RatingSlider({
    Key? key,
    required this.rate,
    required this.giveRating,
  }) : super(key: key);

  final double rate;
  final void Function(double rating) giveRating;

  @override
  State<RatingSlider> createState() => _RatingSliderState();
}

class _RatingSliderState extends State<RatingSlider> {
  double _sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
        Text(_sliderValue.toStringAsFixed(1)),
        SizedBox(
          width: 200,
          child: Slider(
            value: _sliderValue,
            min: 0,
            max: 5,
            activeColor: Colors.amber,
            label: _sliderValue.round().toString(),
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
              widget.giveRating(value);
            },
          ),
        ),
      ],
    );
  }
}
