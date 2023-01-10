import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  // if we don't like to rotate
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        accentColor: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transList = [];
  bool _showChart = true;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: Random().nextInt(99).toString(),
      title: txTitle.toString(),
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _transList.add(newTx);
    });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transList.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  List<Transaction> _recentTrans() {
    return _transList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final myAppBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          onPressed: () => {_startAddNewTransaction(context)},
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final txList = Container(
      height: (mediaQuery.size.height - myAppBar.preferredSize.height) * 0.7,
      child: TransactionList(_transList, _deleteTransaction),
    );
    return Scaffold(
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: isLandscape
                  ? (mediaQuery.size.height -
                          myAppBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7
                  : (mediaQuery.size.height -
                          myAppBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
              child: _showChart
                  ? Chart(
                      _recentTrans(),
                    )
                  : txList,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
