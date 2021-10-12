import 'package:expenses/models/expenses.dart';
import 'package:expenses/utils/components.dart';
import 'package:expenses/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddNewExpense extends StatefulWidget {
  @override
  AddNewExpenseState createState() => AddNewExpenseState();
}

class AddNewExpenseState extends State<AddNewExpense> {
  bool applyLoading = false;
  String _name;
  var classType;
  String _amount;
  final List<Expenses> userExpensesList = [];
  @override
  Widget build(BuildContext context) {
    double maxWidth = 350;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Material(
          color: theme.scaffoldBackgroundColor,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(kMediumPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    "Add Transaction",
                    style: textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kMediumPadding),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: kPadding),
                      decoration: kTextFieldBoxDecoration.copyWith(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: new Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.white,
                        ),
                        child: new DropdownButtonHideUnderline(
                            child: DropdownButton<DailyExpenses>(
                                isExpanded: true,
                                value: classType,
                                hint: Text("Transaction type"),
                                onChanged: (DailyExpenses newValue) {
                                  setState(() {
                                    classType = newValue;
                                  });
                                },
                                items: DailyExpenses.values
                                    .map((DailyExpenses classType) {
                                  return DropdownMenuItem<DailyExpenses>(
                                      value: classType,
                                      child: Text(
                                          classType == DailyExpenses.expenses
                                              ? "Expenses"
                                              : "Income"));
                                }).toList())),
                      )),
                  SizedBox(height: kMediumPadding),
                  RoundedInputField(
                      backgroundColor: Colors.white,
                      key: Key('inputTransactDesc'),
                      hintText: 'Transaction Description',
                      keyboardType: TextInputType.text,
                      onChanged: (result) => _name = result),
                  SizedBox(height: kRegularPadding),
                  RoundedInputField(
                      prefix: Text("\$"),
                      backgroundColor: Colors.white,
                      key: Key('inputTransactAmount'),
                      hintText: 'Transaction Amount',
                      keyboardType: TextInputType.number,
                      onChanged: (result) => _amount = result),
                  SizedBox(height: kLargePadding),
                  WidgetButton(
                    widget: Text(
                      "Add",
                      style: theme.textTheme.bodyText2
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      var now = new DateTime.now();
                      var formatter = new DateFormat('yyyy-MM-dd');
                      String formattedDate = formatter.format(now);
                      addNewExpense(formattedDate, classType, _name,
                          double.parse(_amount));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addNewExpense(String date, DailyExpenses dailyExpense, String description,
      double amount) async {
    final userExpenses = Expenses(dailyExpense, description, amount, date);
    final box = Hive.box("UserExpensesDetails");
    box.add(userExpenses);
    Navigator.pop(context);
  }
}
