import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 221, 97, 9)),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(title: 'Calculator App'),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key, required this.title});
  final String title;

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _evaluateExpression();
      } else if (value == 'Clear') {
        _clearExpression();
      } else {
        _expression += value;
      }
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
    });
  }

  void _evaluateExpression() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});

      if (_expression.contains('/0')) {
        setState(() {
          _expression = 'Error';
        });
        return;
      }
      setState(() {
        _expression = result.toString();
      });
    } catch (e) {
      setState(() {
        _expression = 'Error';
      });
    }
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
                _expression,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                calcButton('7'), calcButton('8'), calcButton('9'), calcButton('Clear'),
                calcButton('4'), calcButton('5'), calcButton('6'), calcButton('*'),
                calcButton('1'), calcButton('2'), calcButton('3'), calcButton('/'),
                calcButton('0'), calcButton('+'), calcButton('-'), calcButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget calcButton(String value) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(value),
      child: Text(value, style: const TextStyle(fontSize: 20)),
    );
  }
}
