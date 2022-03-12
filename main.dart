import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var num = '';
  var res = '';


  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        num,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        res,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {

                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            num = '';
                            res = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white70,
                        textColor: Colors.black,
                      );
                    }


                    else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: Colors.white70,
                        textColor: Colors.black,
                      );
                    }

                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            num += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white70,
                        textColor: Colors.black,
                      );
                    }

                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            num =
                                num.substring(0, num.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white70,
                        textColor: Colors.black,
                      );
                    }

                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[800],
                        textColor: Colors.white,
                      );
                    }


                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            num += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.orangeAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.orange
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finalnum = num;
    finalnum = num.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalnum);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    res = eval.toString();
  }
}