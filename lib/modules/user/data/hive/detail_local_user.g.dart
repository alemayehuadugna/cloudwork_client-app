// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_local_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailLocalUserAdapter extends TypeAdapter<DetailLocalUser> {
  @override
  final int typeId = 20;

  @override
  DetailLocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailLocalUser(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      (fields[7] as List).cast<String>(),
      fields[8] as bool,
      fields[9] as String,
      fields[10] as bool,
      (fields[11] as List).cast<SocialLinkModel>(),
      (fields[12] as List).cast<FavoriteModel>(),
      fields[13] as RatingModel,
      fields[14] as String,
      fields[15] as int,
      fields[16] as int,
      fields[17] as int,
      fields[18] as bool,
      fields[19] as double,
      fields[20] as double,
      fields[21] as AddressModel?,
      (fields[22] as List).cast<String>(),
      fields[25] as DateTime,
      fields[23] as String,
      fields[24] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailLocalUser obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.roles)
      ..writeByte(8)
      ..write(obj.verified)
      ..writeByte(9)
      ..write(obj.profilePicture)
      ..writeByte(10)
      ..write(obj.isEmailVerified)
      ..writeByte(11)
      ..write(obj.socialLinks)
      ..writeByte(12)
      ..write(obj.favorites)
      ..writeByte(13)
      ..write(obj.rating)
      ..writeByte(14)
      ..write(obj.profileUrl)
      ..writeByte(15)
      ..write(obj.completedJobs)
      ..writeByte(16)
      ..write(obj.ongoingJobs)
      ..writeByte(17)
      ..write(obj.cancelledJobs)
      ..writeByte(18)
      ..write(obj.isProfileCompleted)
      ..writeByte(19)
      ..write(obj.profileCompletedPercentage)
      ..writeByte(20)
      ..write(obj.spending)
      ..writeByte(21)
      ..write(obj.address)
      ..writeByte(22)
      ..write(obj.workCategory)
      ..writeByte(23)
      ..write(obj.websiteUrl)
      ..writeByte(24)
      ..write(obj.companyName)
      ..writeByte(25)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailLocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocialLinkModelAdapter extends TypeAdapter<SocialLinkModel> {
  @override
  final int typeId = 21;

  @override
  SocialLinkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialLinkModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SocialLinkModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.socialMedia)
      ..writeByte(1)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 22;

  @override
  FavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteModel(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.freelancerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
