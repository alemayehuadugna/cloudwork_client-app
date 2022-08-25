// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_favorite_freelancer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalFavoriteFreelancerAdapter
    extends TypeAdapter<LocalFavoriteFreelancer> {
  @override
  final int typeId = 16;

  @override
  LocalFavoriteFreelancer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalFavoriteFreelancer(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as AddressModel,
      fields[4] as String,
      (fields[5] as List).cast<String>(),
      fields[6] as String,
      fields[7] as RatingModel,
      fields[8] as RatingModel,
      fields[9] as RatingModel,
      fields[10] as RatingModel,
      fields[11] as RatingModel,
      fields[12] as RatingModel,
    );
  }

  @override
  void write(BinaryWriter writer, LocalFavoriteFreelancer obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.skills)
      ..writeByte(6)
      ..write(obj.expertise)
      ..writeByte(7)
      ..write(obj.skillRating)
      ..writeByte(8)
      ..write(obj.qualityOfWorkRating)
      ..writeByte(9)
      ..write(obj.availabilityRating)
      ..writeByte(10)
      ..write(obj.adherenceToScheduleRating)
      ..writeByte(11)
      ..write(obj.communicationRating)
      ..writeByte(12)
      ..write(obj.cooperationRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalFavoriteFreelancerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
