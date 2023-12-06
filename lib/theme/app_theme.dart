import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Color.fromARGB(255, 82, 51, 39),
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];



class AppTheme {

  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  }): assert( selectedColor >= 0, 'Selected color must be greater then 0' ),  
      assert( selectedColor < colorList.length, 
        'Selected color must be less or equal than ${ colorList.length - 1 }');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[ selectedColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 82, 51, 39),
      titleTextStyle: TextStyle(
        color: Colors.white,
        
        fontSize: 25,
      
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    )
  );


}