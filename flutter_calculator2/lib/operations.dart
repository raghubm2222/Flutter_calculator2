import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class Operator extends ValueNotifier {
  Operator(value) : super(value);
  String finalAnswer = '';

  void addNumber(String input) async {
    if (numbers.contains(input) || operators.contains(input)) {
      if (value != '' &&
          operators.contains(input) &&
          operators.contains(value[value.length - 1])) {
        value = value.substring(0, value.length - 1) + input;
      } else {
        finalAnswer = '';
        value += input;
      }
    } else if (value != '' && input == '⌫') {
      finalAnswer = '';
      value = value.substring(0, value.length - 1);
    } else if (input == 'C') {
      finalAnswer = '';
      value = '';
    } else if (input == '=') {
      String val = value;
      if (operators.contains(value[value.length - 1])) {
        val = value.substring(0, value.length - 1);
      }
      var a = val.replaceAll('÷', '/');
      var b = a.replaceAll('×', '*');
      try {
        Parser p = Parser();
        Expression exp = p.parse(b);
        ContextModel cm = ContextModel();
        finalAnswer = exp.evaluate(EvaluationType.REAL, cm).toString();
      } catch (e) {
        finalAnswer = 'Error. \nSorry! we are working hard to get new Feature';
      }
    }
    notifyListeners();
  }
}

var operators = ['+', '-', '÷', '×', '.'];
var numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
