import 'package:flutter/material.dart';
import 'package:game_of_life/game/view/main_page.dart';

void main() {
  runApp(const GameOfLife());
}

class GameOfLife extends StatelessWidget {
  const GameOfLife({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Of Life',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}
