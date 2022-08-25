import 'dart:io';

import 'package:clean_flutter/modules/client-job/views/job_edit/bloc/edit_job_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../common/constant.dart';
import '../../job_post/blocs/post_job_bloc.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../../../_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../common/params.dart';
import '../../../domain/entities/job.dart';
import 'package:dio/dio.dart';

class JobEditDisplay extends StatefulWidget {
  JobEditDisplay({
    Key? key,
    required this.job,
  }) : super(key: key);

  JobDetailEntity job;

  @override
  State<JobEditDisplay> createState() => _JobEditDisplayState();
}

class _JobEditDisplayState extends State<JobEditDisplay> {
  List _items = [];
  final List<String> _categoryItems = [];
  late DateTime initial = DateTime.now();
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();
  final _datePickerController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = <TextEditingController>[
    TextEditingController(text: "")
  ];
  String category = '';
  String language = '';
  List<PlatformFile> files = [];
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _items.clear();
    for (int i = 0; i < widget.job.skills.length; i++) {
      _items.add(Item(
        title: widget.job.skills[i],
        active: true,
        index: 1,
      ));
    }
    linkWidgetBuildCount = 0;
    var isMobile = ResponsiveWrapper.of(context).equals(MOBILE);
    var height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Padding(
      padding: ResponsiveValue<EdgeInsets>(context,
          defaultValue: const EdgeInsets.fromLTRB(80, 10, 80, 10),
          valueWhen: [
            const Condition.equals(
                name: DESKTOP, value: EdgeInsets.fromLTRB(80, 10, 80, 10)),
            const Condition.largerThan(
                name: TABLET, value: EdgeInsets.fromLTRB(50, 10, 50, 10)),
            const Condition.equals(
                name: TABLET, value: EdgeInsets.fromLTRB(50, 10, 50, 10)),
            const Condition.smallerThan(
                name: TABLET, value: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          ]).value!,
      child: Container(
        height: height,
        color: Theme.of(context).cardTheme.color,
        child: Form(
          key: _formKey,
          child: 
          Column(
            children: [
              SizedBox(
                height: isMobile ? height - 148 : height - 200,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        TitleFormWidget(
                            controller: _titleController,
                            title: widget.job.title),
                        const SizedBox(height: 30),
                        BlocConsumer<ListCategoryBloc, ListCategoryState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is ErrorLoadingListCategory) {
                              showTopSnackBar(
                                  title: const Text('Error'),
                                  content: Text(state.message),
                                  icon: const Icon(Icons.error),
                                  context: context);
                              context.loaderOverlay.hide();
                            } else if (state is ListCategoryLoaded) {
                              _categoryItems.clear();
                              for (int i = 0; i < state.category.length; i++) {
                                _categoryItems
                                    .add(state.category[i].categoryName);
                              }
                              context.loaderOverlay.hide();
                            }
                            return DropdownSearch<String>(
                              dropdownSearchDecoration: const InputDecoration(
                                label: Text('Category'),
                              ),
                              popupProps: const PopupProps.menu(
                                menuProps: MenuProps(
                                  constraints: BoxConstraints(maxHeight: 200),
                                ),
                              ),
                              items: _categoryItems,
                              onChanged: (String? data) {
                                setState(() {
                                  category = data!;
                                });
                              },
                              selectedItem: category == ''
                                  ? widget.job.category
                                  : category,
                              validator: (value) {
                                if (value == null) {
                                  return "Select Category.";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        DropdownSearch<String>(
                          dropdownSearchDecoration: const InputDecoration(
                            label: Text('Language'),
                          ),
                          popupProps: const PopupProps.menu(
                            menuProps: MenuProps(
                              constraints: BoxConstraints(maxHeight: 200),
                            ),
                          ),
                          items: const [
                            'English',
                            'Afan Oromo',
                            'Amharic',
                            'Somali',
                            'Tigregna',
                          ],
                          onChanged: (String? data) {
                            setState(() {
                              language = data!;
                            });
                          },
                          selectedItem:
                              language == '' ? widget.job.language : language,
                        ),
                        const SizedBox(height: 30),
                        BudgetFormWidget(
                            controller: _budgetController,
                            budget: widget.job.budget),
                        const SizedBox(height: 30),
                        DurationFormWidget(
                            controller: _durationController,
                            duration: widget.job.duration),
                        const SizedBox(height: 30),
                        SkillTags(
                            tagStateKey: _tagStateKey,
                            items: _items,
                            skills: widget.job.skills),
                        const SizedBox(height: 30),
                        DatePickerTextField(
                          date: initial,
                          initial: initial,
                          controller: _datePickerController,
                          expiry: widget.job.expiry,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Add Document",
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5)),
                              ),
                        ),
                        const SizedBox(height: 10),
                        DocumentCardWidget(files: files
                            // , dio: widget.dio!
                            ),
                        const SizedBox(height: 30),
                        LinkFormWidget(
                            controller: _linkController,
                            links: widget.job.links ?? []),
                        const SizedBox(height: 30),
                        DescriptionFormWidget(
                            controller: _descriptionController,
                            description: widget.job.description),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ActionButton(
                    jobId: widget.job.id,
                    formKey: _formKey,
                    titleController: _titleController,
                    budgetController: _budgetController,
                    datePickerController: _datePickerController,
                    descriptionController: _descriptionController,
                    linkController: _linkController,
                    skills: _items,
                    files: files,
                    category: category == '' ? widget.job.category: category,
                    language: language == '' ? widget.job.language! : language,
                    durationController: _durationController,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  void changeValue(String value) {
    setState(() {
      category = value;
    });
  }
}

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    required this.jobId,
    required this.titleController,
    required this.budgetController,
    required this.datePickerController,
    required this.descriptionController,
    required this.linkController,
    required this.skills,
    required this.files,
    required this.category,
    required this.language,
    required this.formKey,
    required this.durationController,
  }) : super(key: key);

  final String jobId;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController budgetController;
  final TextEditingController datePickerController;
  final TextEditingController descriptionController;
  final List<TextEditingController> linkController;
  final List skills;
  final List<PlatformFile> files;
  final String category;
  final String language;
  final TextEditingController durationController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobPostBloc, JobPostState>(
      listener: (context, state) {
        if (state is ErrorLoadingJobPost) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } else if (state is JobPostLoaded) {
          context.loaderOverlay.hide();
          context.pop();
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomRight,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // getting tittle
                    var title = TextEditingValue(
                      text: titleController.text,
                    );

                    // getting budget
                    var budget = TextEditingValue(
                      text: budgetController.text,
                    );

                    // getting date
                    var date = TextEditingValue(
                      text: datePickerController.text.isEmpty
                          ? ''
                          : datePickerController.text,
                    );

                    // getting links
                    List<String> links = [];
                    var linkLength = TextEditingValue(
                      text: linkController.length.toString(),
                    );
                    for (int i = 0; i < int.parse(linkLength.text); i++) {
                      var link = TextEditingValue(
                        text: linkController[i].text,
                      );
                      if (link.text.isNotEmpty) {
                        links.add(link.text);
                      }
                    }

                    // getting description
                    var description = TextEditingValue(
                      text: descriptionController.text,
                    );

                    // getting links
                    List<String> ListOfSkills = [];
                    var skillLength = skills.length;
                    for (int i = 0; i < skillLength; i++) {
                      ListOfSkills.add(skills[i].title.toString());
                    }
                    // getting duration
                    var duration = TextEditingValue(
                      text: durationController.text,
                    );

                    BlocProvider.of<JobEditBloc>(context).add(EditJobEvent(
                      payload: JobDetailEntity.create(
                        id: jobId,
                        clientId: state is Authenticated ? state.user.id : null,
                        title: title.text,
                        skills: ListOfSkills,
                        budget: double.parse(budget.text),
                        duration: int.parse(duration.text),
                        expiry: date.text,
                        category: category,
                        language: language,
                        links: links,
                        description: description.text,
                        files: files,
                      ),
                    ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class TitleFormWidget extends StatefulWidget {
  TitleFormWidget({Key? key, required this.controller, required this.title})
      : super(key: key);

  late TextEditingController controller;
  final String title;

  @override
  State<TitleFormWidget> createState() => _TitleFormWidgetState();
}

class _TitleFormWidgetState extends State<TitleFormWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.title;
    return TextFormField(
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        label: Text('Title'),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Title is required.";
        }
        return null;
      },
    );
  }
}

class _SkillTagsState extends State<SkillTags> {
  @override
  Widget build(BuildContext context) {
    return Tags(
      key: widget._tagStateKey,
      textField: TagsTextField(
        textStyle: const TextStyle(fontSize: 14),
        enabled: true,
        onSubmitted: (String str) {
          setState(() {
            widget._items.add(Item(
              title: str,
              active: true,
              index: 1,
            ));
          });
        },
      ),
      itemCount: widget._items.length,
      itemBuilder: (int index) {
        final item = widget._items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item.title,
          active: false,
          customData: widget.skills,
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                widget._items.removeAt(index);
              });
              return true;
            },
          ),
        );
      },
    );
  }
}

class SkillTags extends StatefulWidget {
  const SkillTags({
    Key? key,
    required GlobalKey<TagsState> tagStateKey,
    required List items,
    required this.skills,
  })  : _tagStateKey = tagStateKey,
        _items = items,
        super(key: key);

  final GlobalKey<TagsState> _tagStateKey;
  final List _items;
  final List<String> skills;

  @override
  State<SkillTags> createState() => _SkillTagsState();
}

class DatePickerTextField extends StatefulWidget {
  DatePickerTextField(
      {Key? key,
      required this.initial,
      required this.date,
      required this.controller,
      required this.expiry})
      : super(key: key);

  late TextEditingController controller =
      TextEditingController(text: "${date.year}-${date.month}-${date.day}");
  DateTime date;
  DateTime initial;
  final String? expiry;

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    if (buildCount == 0) {
      if (widget.expiry != null) {
        widget.controller.value = TextEditingValue(
          text: widget.expiry!.split('::')[1].split('-')[0] +
              "-" +
              widget.expiry!.split('::')[1].split('-')[1] +
              "-" +
              widget.expiry!
                  .split('::')[1]
                  .split(':')[0]
                  .split('-')[2]
                  .split('T')[0],
        );
      } else {
        widget.controller.value = const TextEditingValue(text: '');
      }
      buildCount++;
    }

    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Enter Date"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      onTap: () async {
        final DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: widget.initial,
          firstDate: widget.initial,
          lastDate: DateTime(2030, 7),
          helpText: 'Select a date',
        ) as DateTime;

        if (newDate != null && newDate != DateTime.now()) {
          widget.controller.clear();
          setState(() {
            widget.date = newDate;
            widget.controller.value = TextEditingValue(
              text: newDate.year.toString() +
                  "-" +
                  newDate.month.toString() +
                  "-" +
                  newDate.day.toString(),
            );
          });
        }
      },
    );
  }
}

class BudgetFormWidget extends StatefulWidget {
  BudgetFormWidget({
    Key? key,
    required this.controller,
    required this.budget,
  }) : super(key: key);

  final TextEditingController controller;
  final double budget;

  @override
  State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.budget.toString();
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
      ],
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Budget"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || double.parse(value) < 50) {
          return "Incorrect Budget. hint: greater than 50.";
        }
        return null;
      },
    );
  }
}

class DurationFormWidget extends StatefulWidget {
  const DurationFormWidget({
    Key? key,
    required this.controller,
    required this.duration,
  }) : super(key: key);

  final TextEditingController controller;
  final int? duration;

  @override
  State<DurationFormWidget> createState() => _DurationFormWidgetState();
}

class _DurationFormWidgetState extends State<DurationFormWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text =
        widget.duration == null ? '' : widget.duration.toString();
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Duration"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Incorrect Duration. hint: Enter At least Minimum Duration";
        }
        return null;
      },
    );
  }
}

class DocumentCardWidget extends StatefulWidget {
  DocumentCardWidget({
    Key? key,
    required this.files,
    // required this.dio,
  }) : super(key: key);

  late TextEditingController controller = TextEditingController(text: "");
  FilePickerResult? result;
  List<PlatformFile> files;
  // final Dio dio;

  @override
  State<DocumentCardWidget> createState() => _DocumentCardWidgetState();
}

class _DocumentCardWidgetState extends State<DocumentCardWidget> {
  final String _downloadPath =
      'https://media.istockphoto.com/photos/boat-riding-in-a-river-picture-id606217830?s=612x612';
  File? _imageFile;
  late String _destPath = 'C:\/Users\/Alex\/Downloads\/Video';
  late CancelToken _cancelToken;
  bool _downloading = false;
  double _downloadRatio = 0.0;
  String _downloadIndicator = '0.00%';

  // @override
  // void initState() {
  //   super.initState();
  //   if (kIsWeb) {
  //     debugPrint('no support');
  //   } else {
  //     getApplicationDocumentsDirectory()
  //         .then((tempDir) => {_destPath = tempDir.path + '/file.dmg'});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          dashPattern: [8, 4],
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 50),
            child: Wrap(
              children: [
                for (int i = 0; i < widget.files.length; i++) ...[
                  SizedBox(
                    width: 120,
                    child: Card(
                      color: Theme.of(context).cardTheme.color,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      widget.files[i].name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 5, 2),
                                  child: IconButton(
                                    color: Theme.of(context).iconTheme.color,
                                    icon: Transform.scale(
                                        scale: 1,
                                        child: const Icon(Icons.delete)),
                                    onPressed: () {
                                      _onremoveFileIconButtonPressed(i);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ],
              // ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () async {
            widget.result =
                await FilePicker.platform.pickFiles(allowMultiple: true);
            _addFiles(widget.result!.files);
            if (widget.result == null) return;
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "Upload",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     if (_imageFile != null)
    //       SizedBox(
    //         width: 200,
    //         height: 200,
    //         child: Image.file(
    //           _imageFile!,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: () => _downLoadFile(
    //           _downloadPath,
    //           _destPath,
    //         ),
    //         child: const Text('Download'),
    //       ),
    //       TextButton(
    //         onPressed: () => _cancelDownload(),
    //         child: const Text("Cancel"),
    //       ),
    //       // TextButton(
    //       //   onPressed: () => _cancelDownload(),
    //       //   child: const Text("Cancel"),
    //       // ),
    //     ]),
    //     const SizedBox(height: 20),
    //     Row(
    //       children: [
    //         Expanded(
    //           child: LinearPercentIndicator(
    //             percent: _downloadRatio,
    //             progressColor: Colors.blue,
    //           ),
    //         ),
    //         Text(_downloadIndicator),
    //       ],
    //     )
    //   ],
    // );
  }

  void _onremoveFileIconButtonPressed(int index) {
    setState(() {
      widget.files.removeAt(index);
    });
  }

  void _addFiles(List<PlatformFile> files) {
    setState(() {
      widget.files.addAll(files);
    });
  }

  void _downLoadFile(String downloadPath, String destPath) async {
    _cancelToken = CancelToken();
    _downloading = true;
    final dio = container.get<Dio>();

    try {
      var x = await dio
          .download(downloadPath, destPath, cancelToken: _cancelToken,
              onReceiveProgress: (int received, int total) {
        if (total != -1) {
          if (!_cancelToken.isCancelled) {
            setState(() {
              _downloadRatio = (received / total);
              if (_downloadRatio == 1) {
                _downloading = false;
              }
              _downloadIndicator = (_downloadIndicator * 100).toString() + '%';
            });
          }
        }
      });

      debugPrint("response: $x");
    } on DioError catch (e) {
      debugPrint("dio error: $e");
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled! ' + e.message);
      }
    } on Exception catch (e) {
      debugPrint("exception error: $e");
      debugPrint(e.toString());
    }
  }

  void _cancelDownload() {
    if (_downloadRatio < 1.0) {
      _cancelToken.cancel();
      _downloading = false;
      setState(() {
        _downloadRatio = 0;
        _downloadIndicator = '0.00%';
      });
    }
  }
}

class LinkFormWidget extends StatefulWidget {
  LinkFormWidget({
    Key? key,
    required this.links,
    required this.controller,
  }) : super(key: key);

  List<TextEditingController> controller;
  List<String>? links;

  @override
  State<LinkFormWidget> createState() => _LinkFormWidgetState();
}

class _LinkFormWidgetState extends State<LinkFormWidget> {
  @override
  Widget build(BuildContext context) {
    if (linkWidgetBuildCount == 0) {
      for (int i = 0; i < widget.links!.length; i++) {
        _onAddIconButtonPressed(false);
      }
      linkWidgetBuildCount++;
    }
    return Column(
      children: [
        StaticLinkWidget(context),
        if (widget.links != null || widget.links!.isEmpty) ...[
          for (int i = 0; i < widget.links!.length; i++) ...[
            DynamicLinkWidget(context, widget.links![i], i + 1),
          ],
        ],
      ],
    );
  }

  Padding StaticLinkWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: widget.controller[0],
              onChanged: (String value) {
                var temp = TextEditingValue(
                  text: widget.controller[0].text,
                );
              },
              decoration: const InputDecoration(
                isDense: true,
                label: Text("Add Links"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              validator: (value) {
                if (!(value!.isEmpty) && !isValidLink(value)) {
                  return "Incorrect Link Address";
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            child: IconButton(
              icon: Transform.scale(scale: 1, child: const Icon(Icons.add)),
              onPressed: () {
                _onAddIconButtonPressed(true);
              },
            ),
          )
        ],
      ),
    );
  }

  Padding DynamicLinkWidget(BuildContext context, String link, int index) {
    widget.controller[index].text = link;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: widget.controller[index],
              onChanged: (String value) {
                var temp = TextEditingValue(
                  text: widget.controller[index].text,
                );
              },
              decoration: const InputDecoration(
                isDense: true,
                label: Text("Add"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              validator: (value) {
                if (!(value!.isEmpty) && !isValidLink(value)) {
                  return "Incorrect Link Address";
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            child: IconButton(
              icon: Transform.scale(scale: 1, child: const Icon(Icons.delete)),
              onPressed: () {
                _onDeleteIconButtonPressed(index);
              },
            ),
          )
        ],
      ),
    );
  }

  void _onAddIconButtonPressed(bool status) {
    setState(() {
      widget.controller.add(TextEditingController(text: ""));
      if (status == true) {
        widget.links!.length++;
      }
    });
  }

  void _onDeleteIconButtonPressed(int index) {
    setState(() {
      widget.controller.removeAt(index);
      widget.links!.removeAt(index - 1);
    });
  }

  bool isValidLink(String value) {
    final linkRegExp = RegExp(
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)');
    return linkRegExp.hasMatch(value);
  }
}

class DescriptionFormWidget extends StatefulWidget {
  DescriptionFormWidget({
    Key? key,
    required this.controller,
    required this.description,
  }) : super(key: key);

  final TextEditingController controller;
  final String description;

  @override
  State<DescriptionFormWidget> createState() => _DescriptionFormWidgetState();
}

class _DescriptionFormWidgetState extends State<DescriptionFormWidget> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.description;
    return TextFormField(
      minLines: 7,
      maxLines: 7,
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        hintText: "Add Description",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Description is required.";
        }
        return null;
      },
    );
  }
}
