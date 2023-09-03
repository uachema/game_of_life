import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // * Game Speed is defined in milliseconds
  final gameSpeed = const Duration(milliseconds: 1000);

  var paused = true;

  void moveToNextGeneration() {
    if (kDebugMode) {
      print('Moving To Next Generation!');
    }
  }

  void gameLoop() async {
    if (!paused) moveToNextGeneration();
    Future.delayed(gameSpeed, gameLoop);
  }

  @override
  void initState() {
    super.initState();
    gameLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => paused = !paused),
                  child: Text(paused ? 'START' : 'PAUSE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
