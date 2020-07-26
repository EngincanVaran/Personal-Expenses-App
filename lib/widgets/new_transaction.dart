import "package:flutter/material.dart";

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction({@required this.addTX});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      print("Debugger --> New Transaction Areas are empty!");
      return;
    }

    widget.addTX(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (input) {
                //   titleInput = input;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => submitData(),
                // onChanged: (input) {
                //   amountInput = input;
                // },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColorLight,
                onPressed: submitData,
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColorDark,
              )
            ],
          ),
        ));
  }
}
