import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constrait) {
              return Column(
                children: <Widget>[
                  const Text(
                    'No Transactions added yet!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: constrait.maxHeight * 0.6,
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(
                    //       'assets/images/zz.webp',
                    //     ),
                    //   ),
                    // ),
                    child: Image.asset('assets/images/zz.webp'),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, idx) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('\$${transactions[idx].amount}'),
                      ),
                    ),
                    title: Text(
                      transactions[idx].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[idx].date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTransaction(transactions[idx].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
