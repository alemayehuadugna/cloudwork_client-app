import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/entities/detail_user.dart';
import 'package:clean_flutter/modules/user/domain/usecase/index.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetDetailUserUsecase _getDetailUser;

  ProfileBloc({required GetDetailUserUsecase getDetailUser})
      : _getDetailUser = getDetailUser,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_getUserProfile);
  }

  void _getUserProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _getDetailUser(NoParams());
    emit(
      result.fold(
          (failure) =>
              const ErrorLoadingProfile(message: "Error Loading Profile"),
          (user) => ProfileLoaded(user: user)),
    );
  }
}
