import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout/cubit/models/player_model.dart';
import 'package:scout/cubit/states.dart';

class PlayersCubit extends Cubit<PlayersStates> {
  PlayersCubit() : super(PlayersInitialState());

  static PlayersCubit get(context) => BlocProvider.of(context);

  late List<PlayersModel> players;
  Future<List<PlayersModel>> getAllPosts(String position) async {
    emit(PlayersGetUserLoadingState());
    players = [];
    FirebaseFirestore.instance
        .collection('players')
        .where('type', isEqualTo: position)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        players.add(PlayersModel.fromMap(
          element.data(),
        ));
        print(element);
      }
    });
    emit(PlayersGetUserSuccessState(players));
    return players;
  }
}
