import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;

  void onClick() {
    setState(() {
      counter = counter + 1;
    });
  }

  @override
  void initState() {}

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    print('build');
    //버튼을계속누르면 빌드가 일어날까
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'counter',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text('$counter', style: const TextStyle(fontSize: 30)),
                  IconButton(
                    onPressed: onClick,
                    icon: const Icon(Icons.add_box),
                    iconSize: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
