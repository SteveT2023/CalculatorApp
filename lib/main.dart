import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator App'),
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
  String _display = '';

  void _buttonPress(String value) {
    setState(() {
      _display += value;
    });
  }

  void _cleanDisplay() {
    setState(() {
      _display = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _display,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                _calcButton('7'), _calcButton('8'), _calcButton('9'), _calcButton('Clear'),
                _calcButton('4'), _calcButton('5'), _calcButton('6'), _calcButton('*'),
                _calcButton('1'), _calcButton('2'), _calcButton('3'), _calcButton('/'),
                _calcButton('0'), _calcButton('+'), _calcButton('-'), _calcButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return ElevatedButton(
      onPressed: () {
        if (value == 'Clear') {
          _cleanDisplay();
        } else {
          _buttonPress(value);
        }
      },
      child: Text(value, style: const TextStyle(fontSize: 20)),
    );
  }
}