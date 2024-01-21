import 'package:my_first_flutter_app/enums/game_status.dart';

class GameResponse {
  bool ok = false;
  GameStatus status = GameStatus.gameContinue;
  String? message;

  GameResponse({this.ok = true, required this.status, this.message});
}
