import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SimpleCalculator()));

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String _display = '0';
  double _firstNumber = 0;
  String _operation = '';
  bool _shouldClearDisplay = false;

  void _handleInput(String input) {
    setState(() { 
      // setState makes screen refresh. without this, display stays '0' even if math works.
      if (int.tryParse(input) != null || input == '.') {
        if (_shouldClearDisplay) {
          _display = (input == '.') ? '0.' : input;
          _shouldClearDisplay = false;
        } else {
          _display = (_display == '0' && input != '.') ? input : _display + input;
        }
      } else if (input == 'C') {
        _display = '0';
        _firstNumber = 0;
        _operation = '';
      } else if (input == '=') {
        _calculateResult();
      } else {
        _firstNumber = double.parse(_display);
        _operation = input;
        _shouldClearDisplay = true;
      }
    });
  }

  void _calculateResult() {
    double secondNumber = double.parse(_display);
    if (_operation == '+') _display = (_firstNumber + secondNumber).toString();
    if (_operation == '-') _display = (_firstNumber - secondNumber).toString();
    if (_operation == '*') _display = (_firstNumber * secondNumber).toString();
    if (_operation == '/') {
      _display = (secondNumber != 0) ? (_firstNumber / secondNumber).toString() : 'Error';
    }
    _shouldClearDisplay = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _display, 
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          CalculatorGrid(onTap: _handleInput),
        ],
      ),
    );
  }
}

class CalculatorGrid extends StatelessWidget {
  // constructor gets function from Parent. this is how Child tells Parent what to do. (Widget Padre/Figlio)
  final Function(String) onTap;
  const CalculatorGrid({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['7', '8', '9', '/']),
        _buildRow(['4', '5', '6', '*']),
        _buildRow(['1', '2', '3', '-']),
        _buildRow(['C', '0', '=', '+']),
      ],
    );
  }

 Widget _buildRow(List<String> labels) {
    return Row(
      // use Expanded here so buttons stretch to fill width and no more white space on sides.
      children: labels.map((label) => Expanded(child: _buildButton(label))).toList(),
    );
  }

  Widget _buildButton(String label) {
    Color? buttonColor = Colors.grey[300];
    Color textColor = Colors.black;

    if (label == 'C') {
      buttonColor = Colors.red[400];
      textColor = Colors.white;
    } else if (label == '=' || ['+', '-', '*', '/'].contains(label)) {
      buttonColor = Colors.orange[400];
      textColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          minimumSize: const Size(70, 70),
        ),
        onPressed: () => onTap(label),
        child: Text(label, style: const TextStyle(fontSize: 24)),
        // figure out how you make first number, operations, second number all visible.
      ),
    );
  }
}