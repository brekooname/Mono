// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranscationModelAdapter extends TypeAdapter<TranscationModel> {
  @override
  final int typeId = 3;

  @override
  TranscationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranscationModel(
      type: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      category: fields[4] as String,
      purpose: fields[5] as String?,
      id: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranscationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.purpose)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranscationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
