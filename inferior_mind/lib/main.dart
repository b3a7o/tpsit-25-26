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
  bool playing = true;
  bool DarkModeActive = false;
  bool colorBlindModeActive = false;

  ThemeData getTheme(bool isDarkMode){
    final base = isDarkMode ? ThemeData.dark() : ThemeData.light();
    
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.deepPurple,
        secondary: Colors.deepOrangeAccent,
      ),
      scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.deepPurple[700] : Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
        )
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      )
    );
  }

  List<Color> colors = [
    Colors.grey, 
    Colors.deepPurple,
    Colors.green,
    Colors.yellow,
    Colors.deepOrange
  ];

  List<int> codeToGuess = List.filled(4, 0);
  List<int> currentIndexes = List.filled(4, 0);

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
      theme: getTheme(false),
      darkTheme: getTheme(true),
      themeMode: DarkModeActive ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              setState(() {
                DarkModeActive = !DarkModeActive;
              });
            }, 
            icon: Icon(DarkModeActive ? Icons.wb_sunny : Icons.nightlight_round)
          ),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ElevatedButton(
                                onPressed: () => updateIdex(i),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.resolveWith(
                                    (states) => colors[currentIndexes[i]],
                                  ),
                                  shape: Theme.of(context).elevatedButtonTheme.style?.shape,
                                  padding: Theme.of(context).elevatedButtonTheme.style?.padding,
                                  textStyle: Theme.of(context).elevatedButtonTheme.style?.textStyle,
                                  foregroundColor: Theme.of(context).elevatedButtonTheme.style?.foregroundColor,
                                ),
                                child: null//Icon(Icons.refresh_rounded, color: Colors.black, size: 20),
                              ),
                            ),
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
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                      ),
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