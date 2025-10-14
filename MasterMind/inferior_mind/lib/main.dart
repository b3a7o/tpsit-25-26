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
  List<Color> colors = [Colors.grey, Colors.deepPurple, Colors.green, Colors.yellow, Colors.deepOrange];
  List<int> currentIndexes = [0,0,0,0];
  List<int> codeToGuess = List.filled(4, 0);
  bool playing = true;

  @override
  void initState() {
    super.initState();
    generateCodeToGuess();
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
          title: const Text("INFERIOR GAME")
        ),
        body: playing 
        ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => updateIdex(0), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors[currentIndexes[0]],
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  child: Text("${currentIndexes[0]}", style: TextStyle(
                    color: Colors.black,
                    ),
                  ), 
                ),

                ElevatedButton(
                  onPressed: () => updateIdex(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors[currentIndexes[1]],
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  child: Text("${currentIndexes[1]}", style: TextStyle(
                    color: Colors.black,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => updateIdex(2), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors[currentIndexes[2]],
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                  ),
                  child: Text("${currentIndexes[2]}", style: TextStyle(
                    color: Colors.black,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () => updateIdex(3), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors[currentIndexes[3]],
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  child: Text("${currentIndexes[3]}", style: TextStyle(
                    color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: (){
              if(codeFounded()){
                setState(() {
                  playing = false;
                });
              }
            }, 
            child: Text("GUESS"),
            ),

            Text('${codeToGuess[0]}, ${codeToGuess[1]}, ${codeToGuess[2]}, ${codeToGuess[3]}')
          ],
        )

        : Column(
          children: [
            Text('CODE FOUNDED!, click continue to play again', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: (){
                restartGame();
                setState(() {
                  playing = true;
                });
              }, 
              child: Text('Continue', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),)
            )
          ],
        )


      ),
    );
  }
}
