import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seconed_app/model/transaction.dart';
import 'ChartBars.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupTransValue {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index), // declare day by index
        );
        double totalSum = 0.0;
        for (var i = 0; i < recentTrans.length; i++) {
          // sum the amount
          if (recentTrans[i].date.day == weekDay.day &&
              recentTrans[i].date.month == weekDay.month &&
              recentTrans[i].date.year == weekDay.year) {
            totalSum += recentTrans[i].amount;
          } // end if
        } // end loop
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        }; //get methoed return
      },
    );
  }

  double get totalSpend {
    //collect total spend of the day
    return groupTransValue.fold(
      0.0,
      (sum, item) {
        return sum + item['amount'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransValue.map(
            (tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBars(
                  tx['day'],
                  tx['amount'],
                  totalSpend == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / totalSpend,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
