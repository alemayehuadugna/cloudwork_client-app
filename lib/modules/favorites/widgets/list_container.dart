import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/modules/favorites/views/bloc/favorite_freelancers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../domain/entities/favorite_freelancer.dart';
import 'freelancer_card.dart';

class ListContainer extends StatelessWidget {
  final List<FavoriteFreelancerEntity> favorites;
  final ScrollController _scrollController = ScrollController();

  ListContainer({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLargerThanTablet =
        ResponsiveWrapper.of(context).isLargerThan("MOBILE_LARGE");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Freelancers"),
        leading: isLargerThanTablet
            ? null
            : BackButton(
                onPressed: () {
                  context.goNamed(homeRouteName);
                },
              ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 117,
          child: ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent) {
                  context
                      .read<FavoriteFreelancersBloc>()
                      .add(GetFavoriteFreelancersEvent());
                }
              }),
            itemBuilder: (context, index) => FreelancerCard(
              freelancer: favorites[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: favorites.length,
            // children: const [
            //   // FreelancerCard(),
            //   // FreelancerCard(),
            //   // FreelancerCard(),
            //   // FreelancerCard(),
            //   // FreelancerCard(),
            // ],
          ),
        ),
      ),
    );
  }
}
