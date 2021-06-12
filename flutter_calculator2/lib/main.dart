import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator2/operations.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Operator _operator = Operator('');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(flex: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder(
                valueListenable: _operator,
                builder: (context, _notifierValue, __) {
                  bool isCalculated = _operator.finalAnswer != '';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _notifierValue.toString() == ''
                            ? '0.0'
                            : _notifierValue.toString(),
                        style: TextStyle(
                          fontSize: isCalculated ? 30.0 : 35.0,
                          color: isCalculated
                              ? Colors.grey
                              : Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                      if (isCalculated)
                        Text(
                          _operator.finalAnswer,
                          style: TextStyle(
                            fontSize: 40.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('C'),
                      _buildButton('+/-'),
                      _buildButton('%'),
                      _buildButton('⌫'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('÷'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('×'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0'),
                      _buildButton('.'),
                      _buildButton('='),
                      _buildButton('+'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String number) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _operator.addNumber(number);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7 / 5,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: Colors.grey),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 26.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
