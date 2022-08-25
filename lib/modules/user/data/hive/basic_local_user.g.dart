// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_local_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasicLocalUserAdapter extends TypeAdapter<BasicLocalUser> {
  @override
  final int typeId = 15;

  @override
  BasicLocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasicLocalUser(
      fields[16] as String,
      fields[18] as String,
      fields[19] as String,
      fields[20] as String,
      fields[21] as String,
      fields[22] as String,
      fields[23] as String,
      (fields[24] as List).cast<String>(),
      fields[25] as bool,
      fields[27] as bool,
      fields[26] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BasicLocalUser obj) {
    writer
      ..writeByte(11)
      ..writeByte(16)
      ..write(obj.id)
      ..writeByte(18)
      ..write(obj.firstName)
      ..writeByte(19)
      ..write(obj.lastName)
      ..writeByte(20)
      ..write(obj.userName)
      ..writeByte(21)
      ..write(obj.phone)
      ..writeByte(22)
      ..write(obj.description)
      ..writeByte(23)
      ..write(obj.email)
      ..writeByte(24)
      ..write(obj.roles)
      ..writeByte(25)
      ..write(obj.verified)
      ..writeByte(26)
      ..write(obj.profilePicture)
      ..writeByte(27)
      ..write(obj.isEmailVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasicLocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
