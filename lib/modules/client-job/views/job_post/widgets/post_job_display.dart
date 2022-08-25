import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../../../_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../domain/entities/job.dart';
import '../blocs/post_job_bloc.dart';

class JobPostDisplay extends StatefulWidget {
  JobPostDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<JobPostDisplay> createState() => _JobPostDisplayState();
}

class _JobPostDisplayState extends State<JobPostDisplay> {
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
    var isMobile = ResponsiveWrapper.of(context).equals(MOBILE);
    var height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    int count = 0;
    var paddingValue =
        ResponsiveValue<double>(context, defaultValue: 150, valueWhen: [
              const Condition.equals(name: DESKTOP, value: 150),
              const Condition.equals(name: TABLET, value: 100),
              const Condition.equals(name: MOBILE, value: 0),
            ]).value ??
            200;
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
          child: Column(
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
                        TitleFormWidget(controller: _titleController),
                        const SizedBox(height: 30),
                        BlocConsumer<ListCategoryBloc, ListCategoryState>(
                          listener: (context, state) {
                            if (state is ErrorLoadingListCategory) {
                              showTopSnackBar(
                                  title: const Text('Error'),
                                  content: Text(state.message),
                                  icon: const Icon(Icons.error),
                                  context: context);
                              context.loaderOverlay.hide();
                            } else if (state is ListCategoryLoading) {
                              context.loaderOverlay.show();
                            } else if (state is ListCategoryLoaded) {
                              for (int i = 0; i < state.category.length; i++) {
                                _categoryItems
                                    .add(state.category[i].categoryName);
                              }
                              context.loaderOverlay.hide();
                            }
                          },
                          builder: (context, state) {
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
                              selectedItem: category == '' ? null : category,
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
                          selectedItem: language == '' ? null : language,
                        ),
                        const SizedBox(height: 30),
                        BudgetFormWidget(controller: _budgetController),
                        const SizedBox(height: 30),
                        DurationFormWidget(controller: _durationController),
                        const SizedBox(height: 30),
                        Text(
                          "Add Skills",
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(1)),
                              ),
                        ),
                        const SizedBox(height: 10),
                        SkillTags(tagStateKey: _tagStateKey, items: _items),
                        const SizedBox(height: 30),
                        DatePickerTextField(
                            date: initial,
                            initial: initial,
                            controller: _datePickerController),
                        const SizedBox(height: 30),
                        Text(
                          "Add Document",
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(1)),
                              ),
                        ),
                        const SizedBox(height: 10),
                        DocumentCardWidget(files: files),
                        const SizedBox(height: 30),
                        LinkFormWidget(controller: _linkController),
                        const SizedBox(height: 30),
                        DescriptionFormWidget(
                            controller: _descriptionController),
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
                    formKey: _formKey,
                    titleController: _titleController,
                    budgetController: _budgetController,
                    datePickerController: _datePickerController,
                    descriptionController: _descriptionController,
                    linkController: _linkController,
                    skills: _items,
                    files: files,
                    category: category,
                    language: language,
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

                    BlocProvider.of<JobPostBloc>(context).add(PostJobEvent(
                      payload: JobDetailEntity.create(
                        id: '',
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
  TitleFormWidget({Key? key, required this.controller}) : super(key: key);

  late TextEditingController controller;

  @override
  State<TitleFormWidget> createState() => _TitleFormWidgetState();
}

class _TitleFormWidgetState extends State<TitleFormWidget> {
  @override
  Widget build(BuildContext context) {
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

class SkillTags extends StatefulWidget {
  const SkillTags({
    Key? key,
    required GlobalKey<TagsState> tagStateKey,
    required List items,
  })  : _tagStateKey = tagStateKey,
        _items = items,
        super(key: key);

  final GlobalKey<TagsState> _tagStateKey;
  final List _items;

  @override
  State<SkillTags> createState() => _SkillTagsState();
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
          active: item.active,
          customData: item.customData,
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

class DatePickerTextField extends StatefulWidget {
  DatePickerTextField(
      {Key? key,
      required this.initial,
      required this.date,
      required this.controller})
      : super(key: key);

  late TextEditingController controller =
      TextEditingController(text: "${date.year}-${date.month}-${date.day}");
  DateTime date;
  DateTime initial;

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Enter Start Date"),
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
  BudgetFormWidget({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  @override
  Widget build(BuildContext context) {
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
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<DurationFormWidget> createState() => _DurationFormWidgetState();
}

class _DurationFormWidgetState extends State<DurationFormWidget> {
  @override
  Widget build(BuildContext context) {
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
        label: Text("Duration In Days"),
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
  DocumentCardWidget({Key? key, required this.files}) : super(key: key);

  late TextEditingController controller = TextEditingController(text: "");
  FilePickerResult? result;
  List<PlatformFile> files;

  @override
  State<DocumentCardWidget> createState() => _DocumentCardWidgetState();
}

class _DocumentCardWidgetState extends State<DocumentCardWidget> {
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
                        child: Row(
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
                              padding: const EdgeInsets.fromLTRB(0, 2, 5, 2),
                              child: IconButton(
                                color: Theme.of(context).iconTheme.color,
                                icon: Transform.scale(
                                    scale: 1, child: const Icon(Icons.delete)),
                                onPressed: () {
                                  _onremoveFileIconButtonPressed(i);
                                },
                              ),
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
}

class LinkFormWidget extends StatefulWidget {
  LinkFormWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  List<TextEditingController> controller;

  @override
  State<LinkFormWidget> createState() => _LinkFormWidgetState();
}

class _LinkFormWidgetState extends State<LinkFormWidget> {
  int length = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaticLinkWidget(context), 
        for (int i = 0; i < length; i++) ...[
          DynamicLinkWidget(context, i + 1),
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
                _onAddIconButtonPressed();
              },
            ),
          )
        ],
      ),
    );
  }

  Padding DynamicLinkWidget(BuildContext context, int index) {
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

  void _onAddIconButtonPressed() {
    setState(() {
      widget.controller.add(TextEditingController(text: ""));
      length++;
    });
  }

  void _onDeleteIconButtonPressed(int index) {
    setState(() {
      widget.controller.removeAt(index);
      length--;
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
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<DescriptionFormWidget> createState() => _DescriptionFormWidgetState();
}

class _DescriptionFormWidgetState extends State<DescriptionFormWidget> {
  @override
  Widget build(BuildContext context) {
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
