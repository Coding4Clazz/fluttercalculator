import 'package:flutter/material.dart';

void main() => runApp(TipCalculatorApp());

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(useMaterial3: true),
      home: TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercentage = 15;

  //calculations

  double get _billAmount {
    return double.tryParse(_billController.text) ?? 0.0;
  }

  double get _tipAmount {
    return _billAmount * _tipPercentage / 100;
  }

  double get _totalAmount {
    return _billAmount + _tipAmount;
  }

  //reset button
  void _resetCalculator() {
    setState(() {
      _billController.clear();
      _tipPercentage = 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _billController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter Bill Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tip Percentage:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _tipPercentage,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label: '${_tipPercentage.toInt()}%',
                    onChanged: (value) {
                      setState(() {
                        _tipPercentage = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Text('${_tipPercentage.toInt()}%'),
              ],
            ),
            SizedBox(height: 30),

            Text(
              'Tip: \$${_tipAmount.toStringAsFixed(2)}',
              style:  TextStyle(fontSize: 18, color: const Color.fromARGB(255, 0, 213, 192)),
            ),
            Text(
              'Total: \$${_totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _resetCalculator,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}