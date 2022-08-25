part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegistrationRequested extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  const RegistrationRequested(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [firstName, lastName, phone, email, password];
}
