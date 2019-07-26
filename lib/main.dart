import 'package:flutter/material.dart';
import 'ui/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/Themes.dart';
import 'ui/home.dart';

const String appTitle = "Just Dart";

bool darkThemeOn = true;

String userName = "John Wick";

SharedPreferences prefs;
ThemeData getThemeCache;

void main() async {
  // gets Shared Preferences Instance
  prefs = await SharedPreferences.getInstance();

  /// set & get Shared Pref. for [userName] String
  if (prefs.getString("userName") != null) {
    userName = prefs.getString("userName");
  } else {
    prefs.setString("userName", userName);
    userName = prefs.getString("userName");
  }

  /// set & get Shared Pref. for [darkThemeOn] bool
  if (prefs.getBool("isDark") != null) {
    darkThemeOn = prefs.getBool("isDark");
  } else {
    prefs.setBool("isDark", darkThemeOn);
    darkThemeOn = prefs.getBool("isDark");
  }

  /// applies ThemeData from ['ui/Themes.dart']
  /// in [getThemeCache] depending on the last
  /// chosen theme (key: "isDark")
  getThemeCache = (darkThemeOn) ? darkTheme(true) : darkTheme(false);

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: getThemeCache,
    darkTheme: darkTheme(true),
    home: Main(),
    title: appTitle,
  ));
}

class Main extends StatefulWidget {
  @override
  MainState createState() => new MainState();
}

class MainState extends State<Main> {
  // triggers when dark theme Switch changed
  void _themeSwitchOnChanged(bool value) => setState(() {
        darkThemeOn = value;
        if (darkThemeOn) {
          darkTheme(true);
        } else {
          darkTheme(false);
        }
      });

  var nameController = TextEditingController();

  // updates user name
  void userNameUpdate() {
    prefs.setString("userName", userName);
    nameController.value =
        TextEditingController.fromValue(TextEditingValue(text: userName)).value;
  }

  @override
  Widget build(BuildContext context) {
    userNameUpdate();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: Drawer(
            child: Container(
              color: darkThemeOn ? black1 : white,
              child: new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 250.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 25.0),
                            color: darkThemeOn ? lightBlack : lightGrey,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 60.0),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/user.png",
                                        height: 100,
                                      ),
                                      SizedBox(height: 16.0),
                                      TextField(
                                        controller: nameController,
                                        textAlign: TextAlign.center,
                                        keyboardAppearance: darkThemeOn
                                            ? Brightness.dark
                                            : Brightness.light,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        onSubmitted: (text) {
                                          userName = text;
                                          userNameUpdate();
                                        },
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                            hintText: "$userName"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 60.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    value: darkThemeOn,
                    onChanged: (changed) {
                      setState(() {
                        _themeSwitchOnChanged(changed);
                        prefs.setBool("isDark", changed);
                      });
                    },
                    title: Text(
                      "Dark Theme",
                    ),
                    inactiveThumbImage:
                        AssetImage("assets/images/planet_dark.png"),
                    activeThumbImage:
                        AssetImage("assets/images/planet_light.png"),
                    inactiveThumbColor: black1,
                    activeColor: white,
                    activeTrackColor: blue1,
                  ),
                ],
              ),
            ),
          ),
          appBar: new AppBar(
            title: new Text(appTitle),
            centerTitle: true,
          ),
          body: Home()),
      theme: darkThemeOn ? darkTheme(true) : darkTheme(false),
      darkTheme: darkTheme(true),
    );
  }
}
