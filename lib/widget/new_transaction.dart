import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTxInput; // function to add the input to transaction
  NewTransaction(this._addTxInput);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleC = TextEditingController();
  // prpety to assign the value from textfelid widget
  final amountC = TextEditingController();
  DateTime _selecteDate;

  void submitData() {
    if (amountC.text.isEmpty) {
      return;
    }
    final enterdTitle = titleC.text;
    final enterdAmount = double.parse(amountC.text);

    if (enterdTitle.isEmpty || enterdAmount < 0 || _selecteDate == null) {
      //for sure if the inputs is correct
      return;
    }
    widget._addTxInput(enterdTitle, enterdAmount,
        _selecteDate); //here methoed will add the inputs to transaction list
    Navigator.of(context)
        .pop(); //this widget to close the last or upper widget or anything in the screen
  }

  void _datePopSheet() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then(
      (date) {
        if (date == null) {
          return;
        } else {
          setState(
            () {
              _selecteDate = date;
            },
          );
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // this widget to make styling around the content
        margin: EdgeInsets.all(10),
        child: Column(
          //colum for text fields widget
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                // this widget to take the input from user
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                cursorColor: Colors.black,
                onSubmitted: (_) => submitData(),
                controller: titleC),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountC,
              cursorColor: Colors.black,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selecteDate == null
                          ? 'No date'
                          : DateFormat.yMd().format(_selecteDate),
                    ),
                  ),
                  IconButton(
                    onPressed: _datePopSheet,
                    icon:
                        Icon(Icons.date_range, size: 30, color: Colors.indigo),
                  )
                ],
              ),
            ),
            ElevatedButton(
              // button for accept the inputs
              onPressed: submitData,
              child: Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
