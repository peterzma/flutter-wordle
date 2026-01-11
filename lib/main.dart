import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() { 
  runApp(const App()); 

  
  doWhenWindowReady(() {
    appWindow.size = const Size(500, 783);
    appWindow.minSize = const Size(500, 783);
    appWindow.maxSize = const Size(500, 783);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}