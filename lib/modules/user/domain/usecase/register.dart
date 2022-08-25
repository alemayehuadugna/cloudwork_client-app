import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/user/domain/repo/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase implements UseCase<String, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  const RegisterParams(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [firstName, lastName, phone, email, password];
}
