import 'package:flutter/material.dart';

import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        alignment: Alignment.center,
                        child: Text(
                          '₹ ' + transactions[index].amount.toStringAsFixed(1),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () {
                            removeTransaction(transactions[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: Text(
                            'Delete',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (() {
                            removeTransaction(transactions[index].id);
                          }),
                          color: Theme.of(context).errorColor,
                        ));
            },
            itemCount: transactions.length,
          );
  }
}
