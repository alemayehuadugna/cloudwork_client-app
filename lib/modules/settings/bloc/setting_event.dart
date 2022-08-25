part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends SettingEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordSubmitted(
      {required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class UpdateBasicInfoEvent extends SettingEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const UpdateBasicInfoEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone});

  @override
  List<Object> get props => [firstName, lastName, email, phone];
}

class UpdateAddressEvent extends SettingEvent {
  final Address address;

  const UpdateAddressEvent({required this.address});

  @override
  List<Object> get props => [address];
}

class UpdateDescriptionEvent extends SettingEvent {
  final String description;

  const UpdateDescriptionEvent({required this.description});

  @override
  List<Object> get props => [description];
}

class UpdateOverviewEvent extends SettingEvent {
  final String companyName;
  final String websiteUrl;

  const UpdateOverviewEvent(
      {required this.companyName, required this.websiteUrl});

  @override
  List<Object> get props => [companyName, websiteUrl];
}

class UploadProfilePictureEvent extends SettingEvent {
  // ignore: prefer_typing_uninitialized_variables
  final file;

  const UploadProfilePictureEvent(this.file);

  @override
  List<Object> get props => [file];
}

class UpdateSocialLinksEvent extends SettingEvent {
  final List<SocialLink> socialLinks;

  const UpdateSocialLinksEvent({required this.socialLinks});

  @override
  List<Object> get props => [socialLinks];
}

class DeleteAccountEvent extends SettingEvent {
  final String reason;
  final String password;

  const DeleteAccountEvent(this.reason, this.password);

  @override
  List<Object> get props => [reason, password];
}

class FeedbackEvent extends SettingEvent {
  final String firstName;
  final String lastName;
  final String message;
  final String title;

  const FeedbackEvent(this.firstName, this.lastName, this.message, this.title);

  @override
  List<Object> get props => [firstName, lastName, message, title];
}

class ResetPasswordEvent extends SettingEvent {
  final String email;
  final String password;

  const ResetPasswordEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
