import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true), 
      home: MyCustomCounter(),
    );
  }
}

class MyCustomCounter extends StatefulWidget {
  @override
  _MyCustomCounterState createState() => _MyCustomCounterState();
}

class _MyCustomCounterState extends State<MyCustomCounter> {
  double _counter = 0; 
  double _step = 1; 

  void _increment() {
    setState(() {
      if (_counter + _step <= 100) {
        _counter += _step;
      } else {
        _counter = 100;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_counter - _step >= 0) {
        _counter -= _step;
      } else {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBrown = Colors.brown[900]!; 
    final Color lightCream = Colors.orange[50]!; 
    final Color accentGold = Colors.orange[300]!;

    return Scaffold(
      backgroundColor: darkBrown,
      appBar: AppBar(
        title: const Text('Contatore Personalizzato'),
        backgroundColor: Colors.brown[800],
        foregroundColor: lightCream,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valore Contatore: ${_counter.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: lightCream,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Seleziona Step: ${_step.toStringAsFixed(1)}',
              style: TextStyle(color: lightCream),
            ),
            Slider(
              value: _step,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: accentGold,
              inactiveColor: Colors.brown[400],
              thumbColor: accentGold,
              label: _step.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _step = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGold,
                    foregroundColor: darkBrown,
                  ),
                  onPressed: () { _decrement(); },
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGold,
                    foregroundColor: darkBrown,
                  ),
                  onPressed: () { _increment(); },
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}