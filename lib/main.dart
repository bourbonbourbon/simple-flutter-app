import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/form_screen.dart';

void main() => runApp(const FirstApp());

class FirstApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  const FirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Simple Flutter App',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.purple, brightness: Brightness.dark),
            themeMode: currentMode,
            // ignore: prefer_const_constructors
            home: HomePage(),
          );
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            // ignore: prefer_const_constructors
            context, MaterialPageRoute(builder: (context) => FormScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

// TODO: use unused variables to display message at the bottom after a certain operation
// TODO: handle errors for delete record and show message
// TODO: handle errors for various other fields
// TODO: display records in a table
// TODO: display message when there are no records to display
// TODO: find any descrepencies and correct them (eg strings, filename, variable name, capitalization, etc.)
// TODO: remember theme state using shared_preferences
// TODO: add a better splash screen
// TODO: singlescrollview bugs out at times for Row ID
// TODO: add comments explaining the code
// TODO: change app name and icon everywhere