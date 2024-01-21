import 'package:my_first_flutter_app/enums/player.dart';
import 'package:my_first_flutter_app/logic/game_response.dart';

import '../enums/game_status.dart';

GameResponse getGameState(List<List<Player?>> board) {
  for (var i = 0; i < 3; i++) {
    if (board[i][0] == null) continue;
    if (board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
      return GameResponse(
          status: GameStatus.gameWin,
          message: 'The winner is ${board[i][0] == Player.x ? 'X' : 'O'}');
    }
  }

  for (var i = 0; i < 3; i++) {
    if (board[0][i] == null) continue;
    if (board[0][i] == board[1][i] && board[0][i] == board[2][i]) {
      return GameResponse(
          status: GameStatus.gameWin,
          message: 'The winner is ${board[0][i] == Player.x ? 'X' : 'O'}');
    }
  }

  if (board[0][0] != null &&
      board[0][0] == board[1][1] &&
      board[0][0] == board[2][2]) {
    return GameResponse(
        status: GameStatus.gameWin,
        message: 'The winner is ${board[0][0] == Player.x ? 'X' : 'O'}');
  }

  if (board[0][2] != null &&
      board[0][2] == board[1][1] &&
      board[0][2] == board[2][0]) {
    return GameResponse(
        status: GameStatus.gameWin,
        message: 'The winner is ${board[0][2] == Player.x ? 'X' : 'O'}');
  }

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (board[i][j] == null) {
        return GameResponse(status: GameStatus.gameContinue);
      }
    }
  }

  return GameResponse(status: GameStatus.gameDraw);
}
