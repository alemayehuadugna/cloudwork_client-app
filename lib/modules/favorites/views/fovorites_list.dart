import 'package:clean_flutter/_core/di/get_It.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/widgets/message_display.dart';
import 'package:clean_flutter/modules/favorites/views/bloc/favorite_freelancers_bloc.dart';
import 'package:clean_flutter/modules/favorites/widgets/list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesLists extends StatelessWidget {
  const FavoritesLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: favoritesBody(context));
  }

  BlocProvider<FavoriteFreelancersBloc> favoritesBody(BuildContext context) {
    return BlocProvider(
      create: (context) => container<FavoriteFreelancersBloc>(),
      child: SafeArea(
        child: BlocBuilder<FavoriteFreelancersBloc, FavoriteFreelancersState>(
            builder: (((context, state) {
          if (state is ListFavoriteFreelancersInitial ||
              state is ListFavoriteFreelancersLoading) {
            var _favoriteFreelancersBloc =
                BlocProvider.of<FavoriteFreelancersBloc>(context);
            _favoriteFreelancersBloc.add(GetFavoriteFreelancersEvent());
          } else if (state is ListFavoriteFreelancersLoaded) {
            return ListContainer(favorites: state.favoriteFreelancers);
            // print("successfully ");
          } else if (state is ErrorLoadingFavoriteFreelancers) {
            return MessageDisplay(message: state.message);
          }
          return Container();
        }))),
      ),
    );
  }
}
