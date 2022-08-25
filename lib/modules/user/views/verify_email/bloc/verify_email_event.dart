part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class VerifyEmailRequested extends VerifyEmailEvent {
  final String code;
  final String email;

  const VerifyEmailRequested({required this.code, required this.email});

  @override
  List<Object> get props => [code, email];
}

class VerifyForgetEmailEvent extends VerifyEmailEvent {
  final String code;
  final String email;

  VerifyForgetEmailEvent({required this.code, required this.email});

  @override
  List<Object> get props => [code, email];
}

class ResendOTPRequested extends VerifyEmailEvent {
  final String email;
  final String type;

  const ResendOTPRequested({required this.email, required this.type});

  @override
  List<Object> get props => [email];
}
