import "package:flutter/material.dart";

import "./transaction_list.dart";
import "./new_transaction.dart";
import "../models/transaction.dart";

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'T1',
      title: "New Shoes",
      amount: 49.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: "Groceries",
      amount: 150,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T3',
      title: "MacBook Air",
      amount: 1199.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTX = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString() + amount.toString(),
    );

    setState(() {
      _userTransactions.add(newTX);
    });

    print(
      "Debugger --> New TX is added!" + title + "-" + amount.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          addTX: _addNewTransaction,
        ),
        TransactionList(
          transactions: _userTransactions,
        ),
      ],
    );
  }
}
