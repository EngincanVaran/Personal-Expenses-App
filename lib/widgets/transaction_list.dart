import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({
    @required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Transactions!",
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
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
                            color: Theme.of(context).primaryColorDark,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          transactions[index].amount.toStringAsFixed(2) + "₺",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            // ignore: deprecated_member_use
                            style: Theme.of(context).textTheme.title,
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
