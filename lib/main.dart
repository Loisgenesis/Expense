import 'package:expenses/add_new_expense.dart';
import 'package:expenses/models/expenses.dart';
import 'package:expenses/utils/constants.dart';
import 'package:expenses/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "package:collection/collection.dart";
import 'package:toast/toast.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final document = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ExpensesAdapter());
  Hive.registerAdapter(DailyExpensesAdapter());
  await Hive.openBox("UserExpensesDetails");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: kThemeData,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: kAppTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box("UserExpensesDetails").listenable(),
        builder: (context, box, _) {
          List<Expenses> user = box.values.toList().cast<Expenses>();
          var newMap = groupBy(user, (obj) => obj.dateTime);
          return buildExpenseContent(newMap, user);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExpense,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildExpenseContent(Map<dynamic, List<Expenses>> userExpense,
      List<Expenses> userExpenseDetails) {
    double totalExpense = 0;
    double totalIncome = 0;
    double totalBalance = 0;
    double totalPercent = 0;
    userExpenseDetails.forEach((element) {
      if (element.type == DailyExpenses.expenses) {
        totalExpense += element.amount;
      } else if (element.type == DailyExpenses.income) {
        totalIncome += element.amount;
      }
      totalBalance = totalIncome - totalExpense;
      totalPercent = totalExpense / totalIncome;
    });
    if (userExpense == null || userExpense.isEmpty) {
      return Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(kMediumPadding),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kMediumPadding, horizontal: kPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Expenses"),
                            SizedBox(
                              height: kPadding,
                            ),
                            Text(kPriceFormatter(totalExpense)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Income"),
                            SizedBox(
                              height: kPadding,
                            ),
                            Text(kPriceFormatter(totalIncome)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Balance"),
                            SizedBox(
                              height: kPadding,
                            ),
                            Text(kPriceFormatter(totalBalance)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kMediumPadding),
                    new LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: totalPercent >= 1 ? 0.0 : totalPercent,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: new ListView.builder(
              itemCount: userExpense.length,
              itemBuilder: (BuildContext context, int index) {
                String date = userExpense.keys.elementAt(index);
                List value = userExpense.values.elementAt(index);
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: kMediumPadding),
                      decoration: BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: new Text("$date")),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      margin: EdgeInsets.symmetric(horizontal: kMediumPadding),
                      decoration: kRoundedEdgesBoxDecoration(
                          borderColor: Colors.grey, radius: 1),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(8),
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onLongPress: () {
                                final box = Hive.box("UserExpensesDetails");
                                setState(() {
                                  box.deleteAt(index);
                                  Toast.show("Expense Deleted", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                });
                              },
                              child: newExpense(value[index]));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget newExpense(Expenses expenses) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(kSmallPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(expenses.description),
          RichText(
            text:
                TextSpan(style: theme.textTheme.bodyText1, children: <TextSpan>[
              TextSpan(text: expenses.type == DailyExpenses.income ? "+" : "-"),
              TextSpan(
                text: kPriceFormatter(expenses.amount),
                style: theme.textTheme.bodyText2
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _addNewExpense() {
    WidgetBuilder builder = (_) => AddNewExpense();
    showDialog(context: context, builder: builder, barrierDismissible: false);
  }
}
