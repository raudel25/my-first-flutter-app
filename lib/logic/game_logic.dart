import 'package:my_first_flutter_app/enums/game_status.dart';
import 'package:my_first_flutter_app/enums/game_type.dart';
import 'package:my_first_flutter_app/enums/player.dart';
import 'package:my_first_flutter_app/logic/game_min_max.dart';
import 'package:my_first_flutter_app/logic/game_response.dart';
import 'package:my_first_flutter_app/logic/game_rules.dart';

class GameLogic {
  Player current = Player.x;
  GameType type;
  bool run = true;

  List<List<Player?>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  GameLogic({required this.type}) {
    if (type == GameType.oPlayer) {
      playGame(board, current);
      current = (current == Player.x) ? Player.o : Player.x;
    }
  }

  void reset() {
    run = true;
    current = Player.x;
    board = [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];

    if (type == GameType.oPlayer) {
      playGame(board, current);
      current = (current == Player.x) ? Player.o : Player.x;
    }
  }

  GameResponse play(int row, int col) {
    if (!run) {
      return GameResponse(
          ok: false,
          status: GameStatus.gameContinue,
          message: 'The game is over');
    }
    if (board[row][col] != null) {
      return GameResponse(
          ok: false,
          status: GameStatus.gameContinue,
          message: 'The folder is not empty');
    }

    board[row][col] = current;
    GameResponse response = getGameState(board);

    if (response.status != GameStatus.gameContinue) {
      run = false;
      return response;
    }

    current = (current == Player.x) ? Player.o : Player.x;

    if (type != GameType.multiplayer) {
      playGame(board, current);

      response = getGameState(board);
      if (response.status != GameStatus.gameContinue) {
        run = false;
        return response;
      }

      current = (current == Player.x) ? Player.o : Player.x;
    }

    return response;
  }
}
