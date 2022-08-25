import 'package:equatable/equatable.dart';

class SocialLink extends Equatable {
  final String socialMedia;
  final String link;

  const SocialLink(this.socialMedia, this.link);

  @override
  List<Object?> get props => [socialMedia, link];
}
