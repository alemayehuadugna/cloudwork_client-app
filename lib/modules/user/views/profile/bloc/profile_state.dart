part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final DetailUser user;

  const ProfileLoaded({required this.user});
}

class ErrorLoadingProfile extends ProfileState {
  final String message;

  const ErrorLoadingProfile({required this.message});
}
