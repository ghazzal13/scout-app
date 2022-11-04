import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout/cubit/player_model.dart';
import 'package:scout/cubit/states.dart';

class PlayersCubit extends Cubit<PlayersStates> {
  PlayersCubit() : super(PlayersInitialState());

  static PlayersCubit get(context) => BlocProvider.of(context);

  late List<PlayersModel> players;
  late List<PlayersModel> players2;
  void getAllPosts() async {
    players = [];
    FirebaseFirestore.instance.collection('players').snapshots().listen(
      (event) {
        for (var element in event.docs) {
          players.add(PlayersModel.fromMap(
            element.data(),
          ));
          print(element.data());
        }
      },
    );
    // players2 =
    //     FirebaseFirestore.instance.collection('players') ;
    // print(players2);
  }
}
