import 'dart:math';

import 'package:my_first_flutter_app/enums/game_status.dart';
import 'package:my_first_flutter_app/enums/player.dart';
import 'package:my_first_flutter_app/logic/game_rules.dart';

void playGame(List<List<Player?>> board, Player turn) {
  var funcPlayer = (turn == Player.x) ? gamerO : gamerX;
  List<List<int>> possible = [];
  int minimax = (turn == Player.x) ? -10 : 10;

  bool Function(int a, int b) cond =
      (turn == Player.x) ? (a, b) => a > b : (a, b) => a < b;

  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[i].length; j++) {
      if (board[i][j] == null) {
        board[i][j] = turn;

        int aux = funcPlayer(board);
        if (cond(aux, minimax)) {
          minimax = aux;
          possible = [];
        }
        if (aux == minimax) possible.add([i, j]);

        board[i][j] = null;
      }
    }
  }

  List<int> play = possible[Random().nextInt(possible.length)];
  board[play[0]][play[1]] = turn;
}

int gamerX(List<List<Player?>> board) {
  var gameState = getGameState(board);
  if (gameState.status == GameStatus.gameWin) return -1;
  if (gameState.status == GameStatus.gameDraw) return 0;
  int minmax = -10;
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[i].length; j++) {
      if (board[i][j] == null) {
        board[i][j] = Player.x;
        minmax = max(minmax, gamerO(board));
        board[i][j] = null;
        if (minmax == 1) return 1;
      }
    }
  }
  return minmax;
}

int gamerO(List<List<Player?>> board) {
  var gameState = getGameState(board);
  if (gameState.status == GameStatus.gameWin) return 1;
  if (gameState.status == GameStatus.gameDraw) return 0;
  int minmax = 10;
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[i].length; j++) {
      if (board[i][j] == null) {
        board[i][j] = Player.o;
        minmax = min(minmax, gamerX(board));
        board[i][j] = null;
        if (minmax == -1) return -1;
      }
    }
  }
  return minmax;
}
