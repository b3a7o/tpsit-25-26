import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Color> colors = [
    Colors.grey, 
    Colors.deepPurple,
    Colors.green,
    Colors.yellow,
    Colors.deepOrange
  ];

  List<int> codeToGuess = List.filled(4, 0);
  List<int> currentIndexes = List.filled(4, 0);
  bool playing = true;

  final colorButtonIcon = Icon(Icons.refresh_rounded);

  final colorButtonsTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10.0),
      ),
      iconColor: Colors.black,
      iconSize: 1.0
    )
  );

  @override
  void initState() {
    super.initState();
    generateCodeToGuess();
  }

  void resetIndexes(){
    currentIndexes = List.filled(currentIndexes.length, 0);
  }

  void generateCodeToGuess(){
    for(int i=0; i<codeToGuess.length; i++){
      codeToGuess[i] = Random().nextInt(codeToGuess.length) + 1;
    }
  }

  void updateIdex(int i){
    setState(() {
      currentIndexes[i] = (currentIndexes[i] + 1) % colors.length;
    });
  }

  bool codeFounded(){
    for(int i=0; i<currentIndexes.length; i++){
      if(currentIndexes[i] != codeToGuess[i]){
        return false;
      }
    }
    return true;
  }

  void restartGame(){
    currentIndexes = [0,0,0,0];
    generateCodeToGuess();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("INFERIOR GAME"),
        ),
        body: playing
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 4; i++)
                          ElevatedButton(
                            onPressed: () => updateIdex(i),
                            style: colorButtonsTheme.style?.copyWith(
                              backgroundColor: WidgetStatePropertyAll(
                                colors[currentIndexes[i]],
                              ),
                            ),
                            child: colorButtonIcon,
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${codeToGuess[0]}, ${codeToGuess[1]}, ${codeToGuess[2]}, ${codeToGuess[3]}',
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CODE FOUNDED!\nClick continue to play again',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        restartGame();
                        setState(() {
                          playing = true;
                        });
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: playing
            ? FloatingActionButton(
                backgroundColor: Colors.yellow,
                onPressed: () {
                  setState(() {
                    if (codeFounded()) {
                      playing = false;
                    }
                    resetIndexes();
                  });
                },
                child: const Text(
                  "GUESS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              )
            : null,
      ),
    );
  }

}