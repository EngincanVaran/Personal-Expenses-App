import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({
    this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    transactions[index].amount.toStringAsFixed(2) + "₺",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('EEE, MMM d, ' 'yy')
                          .format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
