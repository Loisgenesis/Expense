// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesAdapter extends TypeAdapter<Expenses> {
  @override
  final int typeId = 1;

  @override
  Expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenses(
      fields[0] as DailyExpenses,
      fields[1] as String,
      fields[2] as double,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expenses obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyExpensesAdapter extends TypeAdapter<DailyExpenses> {
  @override
  final int typeId = 2;

  @override
  DailyExpenses read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DailyExpenses.income;
      case 1:
        return DailyExpenses.expenses;
      default:
        return DailyExpenses.income;
    }
  }

  @override
  void write(BinaryWriter writer, DailyExpenses obj) {
    switch (obj) {
      case DailyExpenses.income:
        writer.writeByte(0);
        break;
      case DailyExpenses.expenses:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
