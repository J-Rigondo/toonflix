import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    print('build');
    //버튼을계속누르면 빌드가 일어날까
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme.light(),
          textTheme: const TextTheme(
              displayLarge: TextStyle(color: Color(0xFF232B55)))),
      home: Scaffold(
        body: SafeArea(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
