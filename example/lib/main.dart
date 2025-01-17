import 'package:flutter/material.dart';
import 'dart:async';

import 'package:logger/logger.dart';
import 'package:logger_flutter/logger_flutter.dart';

void main() {
  runApp(MyApp());
  log();
}

var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 30,
    ),
    output: LogConsole.wrap(innerOutput: ConsoleOutput()));

var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0, lineLength: 30), output: LogConsole.wrap(innerOutput: ConsoleOutput()));

int counter = 0;

void log() {
  logger.d("Log message with 2 methods");

  loggerNoStack.i("Info message");

  loggerNoStack.w("Just a warning!");

  logger.e("Error! Something bad happened", "Test Error");

  loggerNoStack.v({"key": counter++, "value": "something"});

  logger.v("azeazdfjkdhfgiudfygiud fuhiogufdhgi udfhogius dhogiudfhg iodfuhgodiugh fidguhfi guhdiguh dgi");

  Future.delayed(Duration(seconds: 5), log);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LogConsoleOnShake(
          child: Center(
            child: Text("Shake Phone to open Console."),
          ),
        ),
      ),
    );
  }
}
