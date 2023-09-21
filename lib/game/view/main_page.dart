import 'dart:math' show Random;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// * Game Speed is defined in milliseconds
const gameSpeed = Duration(milliseconds: 1000);
const gameSize = 100;

class _MainPageState extends State<MainPage> {
  late final TransformationController transformationController;
  var paused = true;
  final aliveIndexes = <int>[];

  void moveToNextGeneration() {
    if (kDebugMode) {
      print('Moving To Next Generation!');
      makeCellAlive(Random().nextInt(gameSize * gameSize));
    }
  }

  void gameLoop() async {
    if (!paused) moveToNextGeneration();
    Future.delayed(gameSpeed, gameLoop);
  }

  void makeCellAlive(int index) {
    if (!aliveIndexes.contains(index)) {
      setState(() => aliveIndexes.add(index));
    }
  }

  @override
  void initState() {
    super.initState();
    const zoomFactor = 6.0;
    const xTranslate = 300.0;
    const yTranslate = 300.0;

    transformationController = TransformationController();

    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -xTranslate);
    transformationController.value.setEntry(1, 3, -yTranslate);
    gameLoop();
  }

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: width,
                width: width,
                color: Colors.white,
                child: InteractiveViewer(
                  maxScale: 6,
                  transformationController: transformationController,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gameSize,
                      mainAxisSpacing: 0.2,
                      crossAxisSpacing: 0.2,
                    ),
                    itemCount: gameSize * gameSize,
                    itemBuilder: (_, index) {
                      final alive = aliveIndexes.contains(index);
                      return Box(
                        glow: alive,
                        onTap: () => makeCellAlive(index),
                      );
                    },
                  ),
                ),
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
        color: glow ? Colors.yellow : Colors.grey,
      ),
    );
  }
}
