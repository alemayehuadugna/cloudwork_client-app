import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteAccountUseCase implements UseCase<void, DeleteAccountParams> {
  final SettingRepository repository;

  DeleteAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(
      reason: params.reason,
      password: params.password,
    );
  }
}

class DeleteAccountParams extends Equatable {
  final String reason;
  final String password;

  const DeleteAccountParams(this.reason, this.password);

  @override
  List<Object> get props => [reason, password];
}
