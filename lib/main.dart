import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';

import "./widgets/new_transaction.dart";
import "./models/transaction.dart";
import "./widgets/transaction_list.dart";
import "./widgets/chart.dart";

void main() {
  // TO DISABLE ANY ORIENTATION USE THIS TYPE OF CODE SNIPPET
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        //errorColor: Colors.red,
        primarySwatch: Colors.orange,
        accentColor: Colors.blue[900],
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput, amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: "New Shoes",
      amount: 49.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: "New Bag",
      amount: 79.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: "New Phonecase",
      amount: 20.5,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: "Groceries",
      amount: 420.25,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: "Macbook Air",
      amount: 1250.50,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions
      ..where((tx) {
        return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTX = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTX);
    });

    print(
      "Debugger --> New TX is added! --> " + title + "-" + amount.toString(),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addTX: _addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final bool _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Personal Expenses"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txListWidget = Container(
      height: (_mediaQuery.size.height -
              appBar.preferredSize.height -
              _mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTX: _deleteTransaction,
      ),
    );

    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Show Chart",
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  )
                ],
              ),
            if (!_isLandscape)
              Container(
                  child: Chart(_recentTransactions),
                  height: (_mediaQuery.size.height -
                          appBar.preferredSize.height -
                          _mediaQuery.padding.top) *
                      0.3),
            if (!_isLandscape) txListWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      child: Chart(_recentTransactions),
                      height: (_mediaQuery.size.height -
                              appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                    )
                  : txListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.playlist_add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            body: _pageBody,
          );
  }
}
