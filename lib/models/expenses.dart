import 'package:hive/hive.dart';
part 'expenses.g.dart';

@HiveType(typeId: 1)
class Expenses  extends HiveObject{
  @HiveField(0)
  DailyExpenses type;

  @HiveField(1)
  String description;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String dateTime;

  Expenses(this.type, this.description, this.amount,this.dateTime);

  @override
  String toString() {
    return 'Expenses{type: $type, description: $description, amount: $amount, dateTime: $dateTime}';
  }
}

@HiveType(typeId: 2)
enum DailyExpenses {
  @HiveField(0)
  income,

  @HiveField(1)
  expenses,
}
