import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../pages/list_freelancers_page.dart';
import 'rating_check_box.dart';

class FilterTile extends StatefulWidget {
  const FilterTile({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterTile> createState() => _FilterTileState();
}

class _FilterTileState extends State<FilterTile> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final skills = ['Web Design', 'UI Design'];

  Widget get _tags {
    return Tags(
      key: _tagStateKey,
      symmetry: false,
      columns: 0,
      textField: _textField,
      itemCount: skills.length,
      alignment: WrapAlignment.start,
      itemBuilder: (index) {
        final item = skills[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            removeButton: ItemTagsRemoveButton(
              onRemoved: () {
                setState(() {
                  skills.removeAt(index);
                });
                return true;
              },
            ),
            activeColor:
                Theme.of(context).chipTheme.backgroundColor!.withOpacity(0.4),
            textColor: Theme.of(context).textTheme.headline6!.color!,
            elevation: 1,
          ),
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      textStyle: const TextStyle(fontSize: 16),
      hintText: "Add a Skill",
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      enabled: true,
      onSubmitted: (String str) {
        setState(() {
          skills.add(str);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            SizedBox(
              height: 58,
              child: Card(
                margin: const EdgeInsets.all(0),
                elevation: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text("Filter",
                          style: Theme.of(context).textTheme.headline5),
                    )),
                    TextButton(onPressed: () {}, child: const Text("Clear All"))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const FilterTextField(label: Text("Enter Keyword")),
                      const SizedBox(height: 15),
                      const FilterTextField(label: Text("Enter Location")),
                      const SizedBox(height: 15),
                      DropdownSearch(
                        dropdownSearchDecoration: const InputDecoration(
                          label: Text('Select Category'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownSearch(
                        dropdownSearchDecoration: const InputDecoration(
                          label: Text('Select Jobs'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .chipTheme
                              .backgroundColor!
                              .withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Opacity(
                              opacity: 0.6,
                              child: Text('Skills',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(height: 5),
                            _tags,
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownSearch(
                        dropdownSearchDecoration: const InputDecoration(
                          label: Text('Availability'),
                        ),
                        popupProps: const PopupProps.menu(
                          menuProps: MenuProps(
                            constraints: BoxConstraints(maxHeight: 100),
                          ),
                        ),
                        items: const ['Part Time', 'Full Time'],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .chipTheme
                              .backgroundColor!
                              .withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Opacity(
                              opacity: 0.6,
                              child: Text('Experience',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(height: 8),
                            ExperienceCheckBox(label: '0-1 years'),
                            ExperienceCheckBox(label: '2-5 years'),
                            ExperienceCheckBox(label: '5-8 years'),
                            ExperienceCheckBox(label: 'Mastered'),
                            ExperienceCheckBox(label: 'Professional'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .chipTheme
                              .backgroundColor!
                              .withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Opacity(
                              opacity: 0.6,
                              child: Text('Reviews',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(height: 8),
                            RatingCheckBox(rating: 5),
                            RatingCheckBox(rating: 4),
                            RatingCheckBox(rating: 3),
                            RatingCheckBox(rating: 2),
                            RatingCheckBox(rating: 1),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {},
              child: const Text("Search"),
            )
          ],
        ),
      ),
    );
  }
}
