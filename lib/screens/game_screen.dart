import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/enums/game_type.dart';
import 'package:my_first_flutter_app/enums/game_status.dart';
import 'package:my_first_flutter_app/enums/player.dart';
import 'package:my_first_flutter_app/logic/game_logic.dart';

class GameScreen extends StatefulWidget {
  final GameType gameType;
  final GameLogic gameLogic;

  GameScreen({super.key, required this.gameType})
      : gameLogic = GameLogic(type: gameType);

  @override
  State<GameScreen> createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  String _playerToStr(Player? p) {
    switch (p) {
      case Player.x:
        return 'X';
      case Player.o:
        return 'O';
      case null:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Border createBorder(int row, int col) {
      BorderSide borderSide = const BorderSide(width: 2.0, color: Colors.black);
      return Border(
        top: borderSide,
        left: borderSide,
        right: col == 2 ? borderSide : BorderSide.none,
        bottom: row == 2 ? borderSide : BorderSide.none,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              widget.gameLogic.reset();
            });
          },
          child: const Icon(Icons.refresh),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      var response =
                          widget.gameLogic.play((index / 3).floor(), index % 3);

                      if (!response.ok) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.message!),
                          ),
                        );
                      }

                      if (response.status == GameStatus.gameWin ||
                          response.status == GameStatus.gameDraw) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response.message!),
                            action: SnackBarAction(
                              label: 'Restart',
                              onPressed: () {
                                setState(() {
                                  widget.gameLogic.reset();
                                });
                              },
                            ),
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: createBorder(
                      (index / 3).floor(),
                      index % 3,
                    )),
                    child: Center(
                      child: Text(
                        _playerToStr(widget.gameLogic.board[(index / 3).floor()]
                            [index % 3]),
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
