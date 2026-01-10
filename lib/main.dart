import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app.dart';
import 'package:window_size/window_size.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Wordle');
    setWindowMinSize(const Size(400, 600));
  }
  
  runApp(const App()); 
}