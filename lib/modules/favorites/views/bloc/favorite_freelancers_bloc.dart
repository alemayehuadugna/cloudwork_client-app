import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/favorites/domain/entities/favorite_freelancer.dart';
import 'package:clean_flutter/modules/favorites/domain/usecase/get_favorite_freelancers.dart';
import 'package:equatable/equatable.dart';

part 'favorite_freelancers_event.dart';
part 'favorite_freelancers_state.dart';

class FavoriteFreelancersBloc
    extends Bloc<FavoriteFreelancersEvent, FavoriteFreelancersState> {
  final GetFavoriteFreelancersUsecase _getFavoriteFreelancersUsecase;
  late int page = 1;
  late int limit = 20;

  FavoriteFreelancersBloc(
      {required GetFavoriteFreelancersUsecase getFavoriteFreelancersUsecase})
      : _getFavoriteFreelancersUsecase = getFavoriteFreelancersUsecase,
        super(ListFavoriteFreelancersInitial()) {
    on<GetFavoriteFreelancersEvent>(_getFavoriteFreelancers);
  }

  void _getFavoriteFreelancers(GetFavoriteFreelancersEvent event,
      Emitter<FavoriteFreelancersState> emit) async {
    emit(ListFavoriteFreelancersLoading());
    final result = await _getFavoriteFreelancersUsecase(
        PaginationParams(page: page, limit: limit));
    emit(result.fold(
      (l) => const ErrorLoadingFavoriteFreelancers(
          message: 'Error loading freelancers'),
      (favFreelancers) {
        page++;
        return ListFavoriteFreelancersLoaded(
            favoriteFreelancers: favFreelancers);
      },
    ));
  }
}
