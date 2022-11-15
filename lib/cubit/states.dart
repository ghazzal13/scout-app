import 'package:scout/cubit/models/player_model.dart';

abstract class PlayersStates {}

class PlayersInitialState extends PlayersStates {}

class PlayersGetUserLoadingState extends PlayersStates {}

class PlayersGetUserSuccessState extends PlayersStates {
  final List<PlayersModel> x;

  PlayersGetUserSuccessState(this.x);
}

class PlayersGetUserErrorState extends PlayersStates {
  final String error;

  PlayersGetUserErrorState(this.error);
}
