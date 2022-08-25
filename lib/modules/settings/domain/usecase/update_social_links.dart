import 'package:clean_flutter/_core/error/failures.dart';
import 'package:clean_flutter/_core/usecase.dart';
import 'package:clean_flutter/_shared/domain/entities/social_link.dart';
import 'package:clean_flutter/modules/settings/domain/repo/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateSocialLinksUseCase
    implements UseCase<String, UpdateSocialLInksParams> {
  final SettingRepository settingRepository;

  UpdateSocialLinksUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, String>> call(params) async {
    return await settingRepository.updateSocialLinks(
        socialLinks: params.socialLinks);
  }
}

class UpdateSocialLInksParams extends Equatable {
  final List<SocialLink> socialLinks;

  const UpdateSocialLInksParams(this.socialLinks);

  @override
  List<Object?> get props => [socialLinks];
}
