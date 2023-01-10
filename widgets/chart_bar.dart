import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrait) {
      return Column(
        children: <Widget>[
          Container(
            height: constrait.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          SizedBox(
            height: constrait.maxHeight * 0.05,
          ),
          Container(
            height: constrait.maxHeight * 0.6,
            width: 8,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrait.maxHeight * 0.05,
          ),
          Container(
            height: constrait.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
