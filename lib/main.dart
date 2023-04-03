import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seconed_app/widget/chart.dart';
import './widget/Transaction_List.dart';
import './widget/new_transaction.dart';
import './model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persoaction',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Color.fromARGB(255, 223, 46, 108),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = []; // list of transaction we will view
  void _addTx(String txTitle, double txAmount, DateTime datePicked) {
    //methoed to add transaction
    final newTx = Transaction(
      // create obj to add in the list
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: datePicked,
    );
    setState(
      () {
        // to add the transaction and rebulid the build widget
        _transaction.add(newTx);
      },
    );
  }

  @override
  void _startAddNewTransaction(BuildContext ctx) {
    // this metohed to show bottom sheet
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        //this where we write the widget to bottom sheet
        return GestureDetector(
          onTap: () {}, //this for dont close the sheet when we click on it
          child: NewTransaction(_addTx), behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTX(String id) {
    //metoed to delete transaction
    setState(
      () {
        _transaction.removeWhere((tx) => tx.id == id);
      },
    );
  }

  List<Transaction> get _recTransaction {
    return _transaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        ); //is After
      }, //end anon methoed
    ).toList(); //end where methoed
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Transaction"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        actions: [
          IconButton(
            //button in appbar
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Chart(_recTransaction),
            ),
            TransactionList(_transaction, _deleteTX)
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // to center the button
      floatingActionButton: FloatingActionButton(
        //floating button in the end of screen
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
