import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';



// Set current app theme here ( light or dark )



ThemeData darkTheme(bool dark) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: (dark) ? black1 : white));

    return (dark) ? themeDark : themeLight;

}


//////////***** DARK THEME *****//////////
final ThemeData themeDark = new ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColorBrightness: Brightness.dark,
    primaryColor: white,
    primaryColorDark: black1,
    backgroundColor: black1,
    accentColor: blue1,
    scaffoldBackgroundColor: black1,
    appBarTheme: AppBarTheme(brightness: Brightness.dark, color: black1),

    // Define the default font family.
    fontFamily: 'Roboto',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
);

//////////***** LIGHT THEME *****//////////
final ThemeData themeLight = new ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    primaryColor: lightGrey,
    primaryColorDark: lightGrey,
    backgroundColor: lightGrey,
    accentColor: blue1,
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(brightness: Brightness.light, color: white),

    // Define the default font family.
    fontFamily: 'Roboto',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
);
