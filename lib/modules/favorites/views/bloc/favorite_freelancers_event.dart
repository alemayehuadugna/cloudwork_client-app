part of 'favorite_freelancers_bloc.dart';

abstract class FavoriteFreelancersEvent extends Equatable {
  const FavoriteFreelancersEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteFreelancersEvent extends FavoriteFreelancersEvent {}
