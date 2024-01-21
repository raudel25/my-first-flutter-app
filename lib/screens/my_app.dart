import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/enums/game_type.dart';
import 'package:my_first_flutter_app/screens/game_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _startGame(GameType gameType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(gameType: gameType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tic Tac Toe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              child: const Text('Play with X'),
              onPressed: () {
                _startGame(GameType.xPlayer);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Play with O'),
              onPressed: () {
                _startGame(GameType.oPlayer);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Multiplayer'),
              onPressed: () {
                _startGame(GameType.multiplayer);
              },
            ),
          ],
        ),
      ),
    );
  }
}
