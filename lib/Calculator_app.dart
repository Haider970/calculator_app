import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operator = "";
  bool _isOperatorClicked = false;

  void _handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _clear();
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_isOperatorClicked) {
          _operator = buttonText;
        } else {
          _isOperatorClicked = true;
          _num1 = double.parse(_currentInput);
          _operator = buttonText;
          _currentInput = "";
        }
      } else if (buttonText == "=") {
        if (_isOperatorClicked && _currentInput.isNotEmpty) {
          double num2 = double.parse(_currentInput);
          double result = _performOperation(_num1, num2, _operator);
          _output = result.toStringAsFixed(2);
          _num1 = 0;
          _isOperatorClicked = false;
          _currentInput = "";
        }
      } else {
        if (_output == "0" || _isOperatorClicked) {
          _currentInput = buttonText;
          _isOperatorClicked = false;
        } else {
          _currentInput += buttonText;
        }
      }
    });
  }

  double _performOperation(double num1, double num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        if (num2 == 0) {
          return double.infinity; // Handle division by zero.
        }
        return num1 / num2;
      default:
        return num2;
    }
  }

  void _clear() {
    _output = "0";
    _currentInput = "";
    _num1 = 0;
    _operator = "";
    _isOperatorClicked = false;
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _handleButtonClick(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[300],
          onPrimary: Colors.black,
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(16.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: Colors.black,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("C"),
                    _buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("="),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
