import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../common/bloc/filter_freelancer_menu_cubit.dart';
import '../bloc/list_freelancer_bloc.dart';
import '../widgets/widgets.dart';

class ListFreelancersPage extends StatelessWidget {
  const ListFreelancersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => container<ListFreelancerBloc>(),
      child: BlocBuilder<ListFreelancerBloc, ListFreelancerState>(
        builder: (context, state) {
          if (state is ListFreelancerInitial) {
            BlocProvider.of<ListFreelancerBloc>(context)
                .add(const LoadFreelancersEvent(null, null, null));
          }
          return Scaffold(
            body: const _BuildBody(),
            endDrawer: const Drawer(child: FilterTile()),
            onEndDrawerChanged: (value) {
              if (!ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
                if (!value) {
                  BlocProvider.of<FilterFreelancerMenuCubit>(context)
                      .hideMenu();
                } else {
                  BlocProvider.of<FilterFreelancerMenuCubit>(context)
                      .showMenu();
                }
              }
            },
          );
        },
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLargerThanTablet =
        ResponsiveWrapper.of(context).isLargerThan(TABLET);

    return BlocListener<FilterFreelancerMenuCubit, bool>(
      listener: (context, state) {
        if (state && !isLargerThanTablet) {
          Scaffold.of(context).openEndDrawer();
        }
      },
      child: BlocBuilder<FilterFreelancerMenuCubit, bool>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: ResponsiveWrapper.of(context).isMobile
                            ? MediaQuery.of(context).size.height - 61
                            : MediaQuery.of(context).size.height,
                        child: BlocBuilder<ListFreelancerBloc,
                            ListFreelancerState>(
                          builder: (context, state) {
                            if (state is ListFreelancerLoaded) {
                              return AlignedGridView.extent(
                                shrinkWrap: true,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 6,
                                itemCount: state.freelancerList.length,
                                maxCrossAxisExtent: 480,
                                itemBuilder: (context, index) {
                                  return FreelancerTile(
                                    freelancer: state.freelancerList[index],
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                onPressed: () {
                                  if (state) {
                                    BlocProvider.of<FilterFreelancerMenuCubit>(
                                            context)
                                        .hideMenu();
                                  } else {
                                    BlocProvider.of<FilterFreelancerMenuCubit>(
                                            context)
                                        .showMenu();
                                  }
                                },
                                icon: const Icon(Icons.filter_list),
                                splashRadius: 26,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state && isLargerThanTablet) const FilterTile(),
            ],
          );
        },
      ),
    );
  }
}

class ExperienceCheckBox extends StatefulWidget {
  const ExperienceCheckBox({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  State<ExperienceCheckBox> createState() => _ExperienceCheckBoxState();
}

class _ExperienceCheckBoxState extends State<ExperienceCheckBox> {
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
        Text(
          widget.label,
          style: Theme.of(context).textTheme.subtitle1!,
        ),
      ],
    );
  }
}

class FilterTextField extends StatelessWidget {
  const FilterTextField({
    Key? key,
    required this.label,
  }) : super(key: key);

  final Text label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        label: label,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
