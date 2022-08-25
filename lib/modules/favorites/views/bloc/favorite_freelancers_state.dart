part of 'favorite_freelancers_bloc.dart';

abstract class FavoriteFreelancersState extends Equatable {
  const FavoriteFreelancersState();

  @override
  List<Object> get props => [];
}

class ListFavoriteFreelancersInitial extends FavoriteFreelancersState {}

class ListFavoriteFreelancersLoading extends FavoriteFreelancersState {}

class ListFavoriteFreelancersLoaded extends FavoriteFreelancersState {
  final List<FavoriteFreelancerEntity> favoriteFreelancers;

  const ListFavoriteFreelancersLoaded({required this.favoriteFreelancers});
}

class ErrorLoadingFavoriteFreelancers extends FavoriteFreelancersState {
  final String message;

  const ErrorLoadingFavoriteFreelancers({required this.message});
}
