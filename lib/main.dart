import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notification_test/local_message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _localMessage = LocalMessage();

  int _counter = 0;
  String _testeMessage = 'Hello World';

  @override
  void initState() {
    _localMessage.onLaunchByMessage(onSelectNotification: (payload) async => _onSelectNotification(payload));

    _localMessage.initialize(onSelectNotification: (payload) {
      _onSelectNotification(payload);
      return Future<void>.value();
    });
    super.initState();
  }

  void _onSelectNotification(String? payload) {
    setState(() {
      print('Hello notification $payload');
      _testeMessage = 'Hello notification $payload';
    });
  }

  void _showNotification() {
    final localMessage = LocalMessage();
    localMessage.show(
      title: 'title',
      body: 'body',
      payload: json.encode({'node': 'value'}),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _showNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _testeMessage,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
