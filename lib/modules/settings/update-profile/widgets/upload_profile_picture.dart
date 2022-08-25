import 'dart:io';

import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/_shared/widgets/show_top_flash.dart';
import 'package:clean_flutter/modules/settings/bloc/setting_bloc.dart';
import 'package:clean_flutter/modules/settings/widgets/dialog_bottom_actions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UploadProfilePicture extends StatefulWidget {
  const UploadProfilePicture(
      {Key? key, required this.imageUrl, required this.fileUploadSuccess})
      : super(key: key);

  final String imageUrl;
  final void Function() fileUploadSuccess;

  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  PlatformFile? pickedFile;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => container<SettingBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: Center(
                  child: SpinKitCircle(
                    color: Theme.of(context).colorScheme.secondary,
                    size: 50.0,
                  ),
                ),
                overlayColor: Colors.black,
                overlayOpacity: 0.7,
                child: BlocConsumer<SettingBloc, SettingState>(
                  listener: (context, state) {
                    if (state is UpdateProfileLoading) {
                      context.loaderOverlay.show();
                    }
                    if (state is ErrorUpdatingProfile) {
                      context.loaderOverlay.show();
                      showTopSnackBar(
                          title: const Text("Error"),
                          content: Text(state.message),
                          icon: const Icon(Icons.error),
                          context: context);
                    }
                    if (state is UpdateProfileSuccess) {
                      context.loaderOverlay.hide();
                      Navigator.of(context, rootNavigator: true).pop();
                      widget.fileUploadSuccess();
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                pickedFile != null
                                    ? kIsWeb
                                        ? Container(
                                            height: 200,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            child: Image.memory(
                                                pickedFile!.bytes!),
                                          )
                                        : Container(
                                            height: 200,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            child: Image.file(
                                                File(pickedFile!.path!)),
                                          )
                                    : widget.imageUrl.isNotEmpty
                                        ? Container(
                                            height: 200,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            child:
                                                Image.network(widget.imageUrl),
                                          )
                                        : Container(
                                            height: 200,
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            child: Image.asset(
                                                "assets/images/profile_placeholder.png"),
                                          ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(360, 50))),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                            type: FileType.any,
                                            allowMultiple: false);
                                    if (result != null) {
                                      setState(() {
                                        pickedFile = result.files.single;
                                      });
                                    } else {}
                                  },
                                  child: const Text("Select Profile Image"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your photo should:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text("- Be a close-up of your face"),
                                    const SizedBox(height: 5),
                                    const Text(
                                        "- Show your face clearly - no sunglasses!"),
                                    const SizedBox(height: 5),
                                    const Text("- Be clear and crisp"),
                                    const SizedBox(height: 5),
                                    const Text("- Have a neutral background"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          DialogBottomActions(onSave: () {
                            BlocProvider.of<SettingBloc>(context)
                                .add(UploadProfilePictureEvent(pickedFile));
                          })
                        ],
                      ),
                    );
                  },
                )),
          ),
        ));
  }
}
