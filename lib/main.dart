import 'package:flutter/material.dart';

import "./widgets/user_transactions.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //String titleInput, amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Personal Expenses",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child: Text(
                    "*CHART*",
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.redAccent,
                  elevation: 5,
                ),
              ),
              UserTransactions(),
            ],
          ),
        ));
  }
}
