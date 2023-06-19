/// Satrdagi ifodani hisoblash

import 'dart:io';
import 'dart:math';

void main(List<String> args) async {
  String expression = stdin.readLineSync() ?? '';
  print(evaluateExpression(expression));
}

num evaluateExpression(String expression) {
  num? result = num.tryParse(expression);
  if (result != null) {
    return result;
  }

  List<String> tokens = expression.split(' ');

  List<num> numbers = [];
  List<String> operators = [];

  void performOperation() {
    String operator = operators.removeLast();
    num b = numbers.removeLast();
    num a = numbers.removeLast();

    switch (operator) {
      case '+':
        numbers.add(a + b);
        break;
      case '-':
        numbers.add(a - b);
        break;
      case '*':
        numbers.add(a * b);
        break;
      case '/':
        numbers.add(a / b);
        break;
      case '%':
        numbers.add(a % b);
        break;
      case '^':
        numbers.add(pow(a, b));
        break;
    }
  }

  for (String token in tokens) {
    if (token == '+' || token == '-') {
      while (operators.isNotEmpty &&
          (operators.last == '+' ||
              operators.last == '-' ||
              operators.last == '*' ||
              operators.last == '/' ||
              operators.last == '%' ||
              operators.last == '^')) {
        performOperation();
      }
      operators.add(token);
    } else if (token == '*' || token == '/' || token == '%') {
      while (operators.isNotEmpty &&
          (operators.last == '*' ||
              operators.last == '/' ||
              operators.last == '%' ||
              operators.last == '^')) {
        performOperation();
      }
      operators.add(token);
    } else if (token == '^') {
      operators.add(token);
    } else if (token == '(') {
      operators.add(token);
    } else if (token == ')') {
      while (operators.isNotEmpty && operators.last != '(') {
        performOperation();
      }
      operators.removeLast();
    } else {
      numbers.add(double.parse(token));
    }
  }

  while (operators.isNotEmpty) {
    performOperation();
  }

  return numbers.first;
}
