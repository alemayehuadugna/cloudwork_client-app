import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/_shared/domain/entities/address.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateAddressUsecase implements UseCase<String, UpdateAddressParams> {
  final SettingRepository settingRepository;

  UpdateAddressUsecase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(UpdateAddressParams params) async {
    return await settingRepository.updateAddress(address: params.address);
  }
}

class UpdateAddressParams extends Equatable {
  final Address address;

  const UpdateAddressParams(this.address);

  @override
  List<Object?> get props => [address];
}
