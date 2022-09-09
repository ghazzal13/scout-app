abstract class PlayersStates {}

class PlayersInitialState extends PlayersStates {}

class PlayersGetUserLoadingState extends PlayersStates {}

class PlayersGetUserSuccessState extends PlayersStates {}

class PlayersGetUserErrorState extends PlayersStates {
  final String error;

  PlayersGetUserErrorState(this.error);
}
