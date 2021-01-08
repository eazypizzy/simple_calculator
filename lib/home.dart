import 'package:flutter/material.dart';
import 'dart:math';
import 'custom_button.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  static String expression = "";
  String result = '';
  int nRows;
  final button = [
    ['C', 'del', '%', '*'],
    ['x²', '.', '0', '/'],
    ['1', '2', '3', '+'],
    ['4', '5', '6', '-'],
    ['7', '8', '9', '=']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          calScreen(),
          calButtons(),
        ],
      ),
    );
  }

  Widget calScreen() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      height: 200,
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              child: Expanded(
                  child: Text(
            expression,
            textAlign: TextAlign.end,
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontSize: (expression.length > 10) ? 15 : 30,
                color: Colors.white),
          ))),
          Container(
              padding: EdgeInsets.all(2),
              child: Text(
                result,
                style: TextStyle(
                    fontSize: (result.length > 10) ? 25 : 50,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }

  Widget calButtons() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          for (nRows = 0; nRows < 5; nRows++) _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
        padding: EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            _buildRow(),
            SizedBox(height: (nRows == 4) ? 0 : 32)
          ],
        ));
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (int i = 0; i < 4; i++)
          FAB(
            onPressed: _eval,
            buttonText: button[nRows][i],
            bcolor: (button[nRows].indexOf(button[nRows][i]) == 3)
                ? Colors.grey[900]
                : Colors.grey[700],
            fcolor: Colors.white,
          )
      ],
    );
  }

  double firstNum;
  var btnState;
  void _eval(buttonText) {
    setState(() {
      if (buttonText == '.' &&
          expression != '' &&
          expression.startsWith('0.')) {
        expression = expression;
      } else if (buttonText == '.' && expression == '') {
        expression = '0.';
      } else if (button[0].contains(buttonText) ||
          buttonText == 'x²' ||
          buttonText == '/' ||
          buttonText == '+' ||
          buttonText == '=') {
        expression = expression;
      } else if (buttonText == '-' && expression == '') {
        expression = '-';
      } else if (buttonText == '-' && expression != '') {
        expression = expression;
      } else {
        expression = expression + buttonText;
      }

      if (buttonText == 'C') {
        firstNum = null;
        expression = '';
        result = '';
      }
      if (buttonText == 'del') {
        if (expression == '') {
          expression = '';
        } else {
          expression = expression.substring(0, expression.length - 1);
        }
      }

      if (buttonText.isNotEmpty) {
        if (buttonText == 'x²' && expression.isNotEmpty) {
          print(firstNum);
          if (firstNum != null) {
            // firstNum = null;
            // expression = '';
            result = (pow(double.parse(result), 2)).toString();
            // expression = result;
            // btnState = 'x²';
          } else {
            result = (pow(double.parse(expression), 2)).toString();
            firstNum = double.parse(result);
            // btnState = 'x²';
          }
        } else if (buttonText == 'x²' && expression.isEmpty) {
          result = (pow(double.parse(result), 2)).toString();
          // btnState = 'x²';
          // firstNum = double.parse(result);
        } else if (expression.isNotEmpty && expression != null) {
          if (firstNum != null) {
            if (btnState == '%') {
              result = ((firstNum / 100) * double.parse(expression)).toString();
            } else if (btnState == '+') {
              result = (firstNum + double.parse(expression)).toString();
            } else if (btnState == '-') {
              result = (firstNum - double.parse(expression)).toString();
            } else if (btnState == '*') {
              result = (firstNum * double.parse(expression)).toString();
            } else if (btnState == '/') {
              result = (firstNum / double.parse(expression)).toString();
            }
            // else if (btnState == 'x²') {
            //   expression = '';
            //   result = (pow(firstNum, 2)).toString();
            // }
          }
          if (firstNum == null || buttonText != btnState) {
            if (buttonText == '%' ||
                buttonText == '/' ||
                buttonText == '+' ||
                buttonText == '-' ||
                buttonText == 'x²' ||
                buttonText == '*') {
              if (firstNum == null) {
                firstNum = double.parse(expression);
              } else {
                firstNum = double.parse(result);
              }
              btnState = buttonText;
              expression = '';
            }
          }
          if (firstNum != null && buttonText == btnState) {
            expression = '';
            firstNum = double.parse(result.toString());
          }
        }
      }
    });
  }
}
