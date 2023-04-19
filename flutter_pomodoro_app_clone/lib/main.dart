import 'package:flutter/material.dart';
import 'package:flutter_pomodoro_app_clone/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xFFE7626C),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF4EDDB),
            titleTextStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF232B55),
            )),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFFFEFEFE),
          ),
          headline2: TextStyle(
            color: Color(0xFFFEFEFE),
          ),
          bodyText1: TextStyle(
            color: Color(0xFFFEFEFE),
          ),
          bodyText2: TextStyle(
            color: Color(0xFF1C2833),
          ),
          button: TextStyle(
            color: Color(0xFFFEFEFE),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
