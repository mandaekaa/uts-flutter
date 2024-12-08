import 'package:flutter/material.dart';


class KalkulatorStandarPage extends StatefulWidget {
  const KalkulatorStandarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KalkulatorStandarPageState createState() => _KalkulatorStandarPageState();
}

class _KalkulatorStandarPageState extends State<KalkulatorStandarPage> {
  String display = '0';
  String input = '';
  double? firstNumber;
  String? operation;

  void inputNumber(String number) {
    setState(() {
      if (input.length < 12) { // Limit panjang angka
        input += number;
        display = input;
      }
    });
  }

  void inputOperation(String op) {
    setState(() {
      if (input.isNotEmpty) {
        firstNumber = double.tryParse(input);
        input = '';
        operation = op;
      }
    });
  }

  void calculate() {
    if (firstNumber != null && input.isNotEmpty && operation != null) {
      double secondNumber = double.tryParse(input) ?? 0;
      double result;

      switch (operation) {
        case '+':
          result = firstNumber! + secondNumber;
          break;
        case '-':
          result = firstNumber! - secondNumber;
          break;
        case '*':
          result = firstNumber! * secondNumber;
          break;
        case '/':
          result = secondNumber != 0 ? firstNumber! / secondNumber : double.nan;
          break;
        default:
          result = 0;
      }

      setState(() {
        display = result.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
        input = display;
        firstNumber = null;
        operation = null;
      });
    }
  }

  void clearAll() {
    setState(() {
      display = '0';
      input = '';
      firstNumber = null;
      operation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Standar'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Tampilan layar
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              color: Colors.black12,
              child: Text(
                display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Tombol kalkulator
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('C', Colors.red, clearAll),
                  _buildButton('±', Colors.grey, () {}), // Placeholder untuk operasi negasi
                  _buildButton('%', Colors.grey, () {}), // Placeholder untuk persen
                  _buildButton('/', Colors.orange, () => inputOperation('/')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('7', Colors.black54, () => inputNumber('7')),
                  _buildButton('8', Colors.black54, () => inputNumber('8')),
                  _buildButton('9', Colors.black54, () => inputNumber('9')),
                  _buildButton('*', Colors.orange, () => inputOperation('*')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('4', Colors.black54, () => inputNumber('4')),
                  _buildButton('5', Colors.black54, () => inputNumber('5')),
                  _buildButton('6', Colors.black54, () => inputNumber('6')),
                  _buildButton('-', Colors.orange, () => inputOperation('-')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('1', Colors.black54, () => inputNumber('1')),
                  _buildButton('2', Colors.black54, () => inputNumber('2')),
                  _buildButton('3', Colors.black54, () => inputNumber('3')),
                  _buildButton('+', Colors.orange, () => inputOperation('+')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('0', Colors.black54, () => inputNumber('0'), flex: 2),
                  _buildButton('.', Colors.black54, () => inputNumber('.')),
                  _buildButton('=', Colors.orange, calculate),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
