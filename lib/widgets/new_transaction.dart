import "dart:io";

import 'package:Personal_Expenses_App/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction({@required this.addTX});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      print("Debugger --> New Transaction Areas are empty!");
      return;
    }

    widget.addTX(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (input) {
                  //   titleInput = input;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (input) {
                  //   amountInput = input;
                  // },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null
                            ? "No Date Chosen!"
                            : "Picked Date: " +
                                DateFormat.yMEd().format(_selectedDate)),
                      ),
                      AdaptiveFlatButton(
                          handler: _presentDatePicker, text: "Choose Date")
                    ],
                  ),
                ),
                FlatButton(
                  textColor: Colors.white,
                  onPressed: _submitData,
                  child: Text("Add Transaction"),
                  color: Theme.of(context).primaryColorDark,
                )
              ],
            ),
          )),
    );
  }
}
