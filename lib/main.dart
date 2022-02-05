import 'dart:math';

import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  late Game _game;

  HomePage({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _input = '';
  String _status = 'ทายเลข 1 ถึง 100';

  int? answerNum;

  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var showSeven = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Row(
                children: [
                  Container(width: 50.0, height: 50.0, color: Colors.blue),
                  Expanded(
                    child: Container(
                      width: 30.0,
                      height: 50.0,
                      //color: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('FLUTTER', textAlign: TextAlign.end,),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  //SizedBox(width: 10.0),
                ],
              ),*/
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container(color: Colors.green, width: 100.0, height: 50.0)),
                  Container(color: Colors.red, width: 50.0, height: 50.0),
                ],
              ),*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 70.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.black)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0, top: 0.0),
                child: Text(
                  '$_input',
                  style: TextStyle(fontSize: 35.0, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0, top: 0.0),
                child: Text(
                  '$_status',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildButton(1),
                  buildButton(2),
                  buildButton(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildButton(4),
                  buildButton(5),
                  buildButton(6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildButton(7),
                  buildButton(8),
                  buildButton(9),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        print('X');
                      },
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Icon(Icons.close, color:  Colors.teal.shade600,),

                      ),
                    ),
                  ),*/
                  buildButton(-2),
                  buildButton(0),
                  buildButton(-1),
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        print('BackSpace');
                      },
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: buildButton(-1),

                      ),
                    ),
                  ),*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('GUESS', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent,
                  ),
                  onPressed: () {
                    var input = _input;
                    var guess = int.tryParse(input);

                    if (guess == null) {
                      _showOkDialog(context, 'ERROR', 'กรุณากรอกตัวเลข');
                      return;
                    }
                    var guessResult = widget._game.doGuess(guess);
                    if (guessResult > 0) {
                      setState(() {
                        _status = '$guess มากเกินไป🍓';
                        _input = '';
                      });
                    } else if (guessResult < 0) {
                      setState(() {
                        _status = '$guess น้อยเกินไป🍓';
                        _input = '';
                      });
                    } else {
                      setState(() {
                        _status =
                            '$guess ถูกต้องนะค้าบ💌 (ทาย ${widget._game.guessCount} ครั้ง)';
                        _input = '';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(int? num) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        child: TextButton(
          ////borderRadius: BorderRadius.circular(25.0),
          onPressed: () {
            if (num == -1) {
              setState(() {
                _input = _input.substring(0, _input.length - 1);
              });
              print('You pressed Backspace button');
            } else if (num == -2) {
              setState(() {
                _input = '';
              });
              print('You pressed close button');
            } else {
              if (_input.length < 3)
                setState(() {
                  _input = _input + '$num';
                });
              print('You pressed $num');
            }
          },
          child: (num == -1)
              ? Icon(
                  Icons.backspace,
                  color: Colors.blue
                )
              : (num == -2)
                  ? Icon(
                      Icons.close,
                      color: Colors.blue
                    )
                  : Text('$num'),


        ),
        width: 50.0,
        height: 50.0,
        //color: Colors.white, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว
        decoration: BoxDecoration(
            color: Colors.yellowAccent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // สีเงา
                offset: Offset(2, 4), // ทิศทางของเงาในแนวนอนและแนวตั้ง ตามลำดับ
                blurRadius: 4.0,
                spreadRadius: 2.0,
              )
            ]),
      ),

    );
  }
}
