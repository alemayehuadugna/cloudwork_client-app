import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'common_model.g.dart';

@HiveType(typeId: 30)
class RatingModel extends Equatable {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final double totalRate;

  @HiveField(2)
  final double totalRaters;

  const RatingModel(this.rate, this.totalRate, this.totalRaters);

  @override
  List<Object?> get props => [rate, totalRate, totalRaters];
}

@HiveType(typeId: 31)
class AddressModel extends Equatable {
  @HiveField(0)
  final String region;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final String? areaName;

  @HiveField(3)
  final String? postalCode;

  const AddressModel(this.region, this.city, this.areaName, this.postalCode);

  @override
  List<Object?> get props => [region, city, areaName, postalCode];
}
