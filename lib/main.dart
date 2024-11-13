import 'package:flutter/material.dart';
import 'package:loop_line/music/music.dart';
import 'package:loop_line/pages/game_screen.dart';
import 'package:loop_line/pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AudioController audioController = AudioController();

  @override
  Widget build(BuildContext context) {
    audioController.initialize().then((_) {
      audioController.startMusic();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoopLine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(
        audioController: audioController,
      ),
    );
  }
}
