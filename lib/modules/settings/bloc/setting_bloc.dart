import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/client-job/common/constant.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/delete_account.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/feedback.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/password/change_password.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/reset_password.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_address.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_basic_info.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_description.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_overview.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/update_social_links.dart';
import 'package:clean_flutter/modules/settings/domain/usecase/upload_profile_picture.dart';
import 'package:equatable/equatable.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  // changePasswordUsecase
  final ChangePasswordUseCase _changePasswordUseCase;
  final UploadProfilePictureUseCase _uploadProfilePictureUseCase;
  final UpdateBasicInfoUseCase _updateBasicInfoUseCase;
  final UpdateAddressUsecase _updateAddressUsecase;
  final UpdateDescriptionUsecase _updateDescriptionUsecase;
  final UpdateOverviewUseCase _updateOverviewUseCase;
  final UpdateSocialLinksUseCase _updateSocialLinksUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final FeedbackUsecase _feedbackUsecase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  SettingBloc(
      {required UploadProfilePictureUseCase uploadProfilePictureUseCase,
      required ChangePasswordUseCase changePassword,
      required UpdateBasicInfoUseCase updateBasicInfoUseCase,
      required UpdateAddressUsecase updateAddressUsecase,
      required UpdateDescriptionUsecase updateDescriptionUsecase,
      required UpdateOverviewUseCase updateOverviewUseCase,
      required UpdateSocialLinksUseCase updateSocialLinksUseCase,
      required DeleteAccountUseCase deleteAccountUseCase,
      required FeedbackUsecase feedbackUsecase,
      required ResetPasswordUseCase resetPasswordUseCase})
      : _changePasswordUseCase = changePassword,
        _uploadProfilePictureUseCase = uploadProfilePictureUseCase,
        _updateBasicInfoUseCase = updateBasicInfoUseCase,
        _updateAddressUsecase = updateAddressUsecase,
        _updateDescriptionUsecase = updateDescriptionUsecase,
        _updateOverviewUseCase = updateOverviewUseCase,
        _updateSocialLinksUseCase = updateSocialLinksUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        _feedbackUsecase = feedbackUsecase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(SettingInitial()) {
    on<ChangePasswordSubmitted>(_changePasswordSubmitted);
    on<UploadProfilePictureEvent>(_uploadProfilePictureEvent);
    on<UpdateBasicInfoEvent>(_updateBasicInfoEvent);
    on<UpdateAddressEvent>(_updateAddressEvent);
    on<UpdateDescriptionEvent>(_updateDescriptionEvent);
    on<UpdateOverviewEvent>(_updateOverviewEvent);
    on<UpdateSocialLinksEvent>(_updateSocialLinksEvent);
    on<DeleteAccountEvent>(_deleteAccountEvent);
    on<FeedbackEvent>(_feedbackEvent);
    on<ResetPasswordEvent>(_resetPasswordEvent);
  }

  Future<void> _changePasswordSubmitted(
      ChangePasswordSubmitted event, Emitter<SettingState> emit) async {
    emit(ChangePasswordLoading());
    try {
      final result = await _changePasswordUseCase(ChangePasswordParams(
          oldPassword: event.oldPassword, newPassword: event.newPassword));
      emit(result.fold((error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }

        return const ErrorUpdatingProfile("Error Changing Password");
      }, (clientId) => UpdateProfileSuccess(data: clientId)));
    } catch (e) {
      emit(const ErrorUpdatingProfile('An unknown error occurred'));
    }
  }

  Future<void> _uploadProfilePictureEvent(
      UploadProfilePictureEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _uploadProfilePictureUseCase(
        UploadProfilePictureParams(event.file));
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile('Error Uploading Profile Picture');
    }, (profilePictureUrl) => UpdateProfileSuccess(data: profilePictureUrl)));
  }

  Future<void> _updateBasicInfoEvent(
      UpdateBasicInfoEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _updateBasicInfoUseCase(UpdateBasicInfoParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone));

    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error Updating Basic Profile");
    }, (clientId) => UpdateProfileSuccess(data: clientId)));
  }

  Future<void> _updateAddressEvent(
      UpdateAddressEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result =
        await _updateAddressUsecase(UpdateAddressParams(event.address));
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error Updating Address");
    }, (clientId) => UpdateProfileSuccess(data: clientId)));
  }

  Future<void> _updateDescriptionEvent(
      UpdateDescriptionEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _updateDescriptionUsecase(
        UpdateDescriptionParams(description: event.description));

    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error Updating Basic Profile");
    }, (clientId) => UpdateProfileSuccess(data: clientId)));
  }

  Future<void> _updateOverviewEvent(
      UpdateOverviewEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());

    final result = await _updateOverviewUseCase(UpdateOverviewParams(
        companyName: event.companyName, websiteUrl: event.websiteUrl));
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile('Error Updating Overviews');
    }, (clientId) {
      return UpdateProfileSuccess(data: clientId);
    }));
  }

  Future<void> _updateSocialLinksEvent(
      UpdateSocialLinksEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _updateSocialLinksUseCase(
        UpdateSocialLInksParams(event.socialLinks));
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error Updating Social Links");
    }, (clientId) => UpdateProfileSuccess(data: clientId)));
  }

  Future<void> _deleteAccountEvent(
      DeleteAccountEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _deleteAccountUseCase(
        DeleteAccountParams(event.reason, event.password));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile(
            'Error Occurred while Deleting Your Account');
      },
      (clientId) => const UpdateProfileSuccess(),
    ));
  }

  Future<void> _feedbackEvent(
      FeedbackEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _feedbackUsecase(FeedbackParams(
        event.firstName, event.lastName, event.message, event.title));
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error occurred");
    }, (feedbackId) => const UpdateProfileSuccess()));
  }

  Future<void> _resetPasswordEvent(
      ResetPasswordEvent event, Emitter<SettingState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _resetPasswordUseCase(
        ResetPasswordParams(email: event.email, password: event.password));
    print(result);
    emit(result.fold((error) {
      if (error is ServerFailure) {
        return ErrorUpdatingProfile(error.message);
      }
      return const ErrorUpdatingProfile("Error occurred");
    }, (clientId) => ResetPasswordSuccess()));
  }
}
