import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
        title: 'Stateful Widget',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // A widget that will be started on the application startup
        home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  //initial couter value
  int _counter = 0;

  // amount the counter will decrement by
  int _decAmount = 10;
  
  //inbetween value to check if the counter is about to go negative
  int _checkNegative = 0;

  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      // p.s. this is a repurposed version of the incr function in the satrter app

      _checkNegative = _counter - _decAmount;
      //using a temp var to see if the app will check before crashing itself from breaking slider
      // didnt actually need it, accidently used || instead of && for 'and' in the conditional

      if (_counter > 0 && _checkNegative >= 0) {_counter = _counter - _decAmount;}
      else {_counter = 0;}
    });
  }
  void _resetButton() {
    setState(() {
      // simply sets counter to 0
      _counter = 0;
    });
  }

  // amount the counter will increment by
  int _incAmount = 10;

  //inbetween value to check if the counter is about to go negative
  int _checkAbove = 0;

  // max value allowed for slider
  int _max = 100;

  void _incrementCounter() {
    setState(() {
      // repurposed the decrement function above to do custom increment

      _checkAbove = _counter + _incAmount;
      //using a temp var to see if the app will check before crashing itself from breaking slider

      if (_checkAbove <= _max) {_counter = _counter + _incAmount;}
      else {_counter = 100;}
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stateful Widget'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                color: Colors.blue,
                child: Text(
                  //displays the current number
                  '$_counter',
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
            ),
            Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _counter = value.toInt();
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),
            ElevatedButton(   //this is the reset button
              onPressed: _resetButton,
              child: const Text('Reset'),
            ),
            ElevatedButton(   //this is the reset button
              onPressed: _incrementCounter,
              child: const Text('Increment Counter'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _decrementCounter,
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        // decrement button - repurposed from increment
      );
    }
}