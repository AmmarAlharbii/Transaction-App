import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  String label;
  final double cost;
  final double costPrecntage;
  ChartBars(this.label, this.cost, this.costPrecntage);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              // cost in chart
              '\$${cost.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                // bottom container
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: costPrecntage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label) // day
      ],
    );
  }
}
