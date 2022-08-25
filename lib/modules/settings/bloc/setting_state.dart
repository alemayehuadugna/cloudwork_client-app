part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();
}

class SettingInitial extends SettingState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordLoading extends SettingState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccess extends SettingState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordFailure extends SettingState {
  final String error;

  const ChangePasswordFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class UpdateProfileLoading extends SettingState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess<T> extends SettingState {
  final T? data;

  const UpdateProfileSuccess({this.data});

  @override
  List<T?> get props => [data];
}

class ResetPasswordSuccess extends SettingState {
  @override
  List<Object?> get props => [];
}

class ErrorUpdatingProfile extends SettingState {
  final String message;

  const ErrorUpdatingProfile(this.message);

  @override
  List<Object?> get props => [message];
}
