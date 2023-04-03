import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

// this widget for output the Transaction
class TransactionList extends StatelessWidget {
  final List<Transaction> transaction; // list
  final Function deltetTx;
  TransactionList(this.transaction, this.deltetTx); // constructer

  Widget build(BuildContext context) {
    return Container(
      height: 500, //hight of screen

      child: transaction
              .isEmpty // this for check the lis is empty or not and display image
          ? Column(
              children: [
                SizedBox(height: 10), // for space
                Text(
                  "List is empty!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  child: Image.asset(
                    //for add image
                    'assets/images/List.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              //this widget to make list of col or row can be scrollable
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                // this to run the list view and make it render by elemnt if it showen in screen
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transaction[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transaction[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      //delete button
                      onPressed: () {
                        deltetTx(transaction[index].id);
                      },
                      icon: Icon(
                        (Icons.delete),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
