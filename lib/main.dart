import 'package:flutter/material.dart';

// isme main() function hai jo application start karta hai
void main() {
  runApp(CalculatorApp());
}

// yeh CalculatorApp StatelessWidget hai, jo main root widget banata hai
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue, // theme color set kiya hai
      ),
      home: CalculatorScreen(), // home screen set kiya hai
    );
  }
}

// yeh StatefulWidget hai kyunki hume dynamic data (numbers) dikhana hai
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";   // initial output set kiya hai
  String _input = "";     // input ko store karne ke liye variable
  double _num1 = 0;       // pehla number store hoga
  double _num2 = 0;       // doosra number store hoga
  String _operator = "";  // operator store hoga

  // isme button press hone pe kya karna hai wo handle kiya hai
  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      setState(() {
        _input = "";
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      });
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _num1 = double.parse(_input); // pehla number ko convert karke store kiya hai
      _operator = buttonText;       // operator ko store kiya hai
      setState(() {
        _input = "";                 // input clear kiya
      });
    } else if (buttonText == ".") {
      if (_input.contains(".")) {
        return; // agar already dot hai to kuch mat karo
      } else {
        setState(() {
          _input = _input + buttonText;
        });
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_input); // doosra number ko parse kiya hai

      // yeh calculations handle karta hai
      if (_operator == "+") {
        _output = (_num1 + _num2).toString();
      } else if (_operator == "-") {
        _output = (_num1 - _num2).toString();
      } else if (_operator == "*") {
        _output = (_num1 * _num2).toString();
      } else if (_operator == "/") {
        _output = (_num1 / _num2).toString();
      }

      setState(() {
        _input = _output;  // result ko input me dikhaya
      });

      // variables ko reset kiya hai
      _num1 = 0;
      _num2 = 0;
      _operator = "";
    } else {
      setState(() {
        if (_input == "0") {
          _input = buttonText;
        } else {
          _input = _input + buttonText;
        }
      });
    }
  }

  // yeh har button banata hai UI ke liye
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0), // button size set kiya hai
        ),
        onPressed: () => buttonPressed(buttonText), // button click event
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'), // AppBar ka title
      ),
      body: Column(
        children: <Widget>[
          // yeh display section hai jaha input/output dikh raha hai
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _input.isEmpty ? _output : _input,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(), // divider lagaya hai display ke neeche
          ),
          // yeh button grid banayi hai
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("CLEAR"),
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
