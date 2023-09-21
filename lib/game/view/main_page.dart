import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// * Game Speed is defined in milliseconds
const gameSpeed = Duration(milliseconds: 1000);
const gameSize = 20;

class _MainPageState extends State<MainPage> {
  var paused = true;
  var gameTable = List.filled(gameSize * gameSize, false);

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
            child: Center(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gameSize,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: gameSize * gameSize,
                itemBuilder: (_, index) {
                  return Box(
                    glow: gameTable[index],
                    onTap: () => setState(() {
                      gameTable[index] = !gameTable[index];
                    }),
                  );
                },
              ),
            ),
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

class Box extends StatelessWidget {
  const Box({
    super.key,
    required this.glow,
    required this.onTap,
  });

  final bool glow;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: glow ? Colors.yellow : Colors.white,
      ),
    );
  }
}
