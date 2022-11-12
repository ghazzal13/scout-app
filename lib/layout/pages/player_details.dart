import 'dart:core';

import 'package:flutter/material.dart';

import 'package:scout/cubit/player_model.dart';
import 'package:scout/layout/widgets/player_widgets/tages_data.dart';

class PlayerDetailsPage extends StatefulWidget {
  final PlayersModel player;
  const PlayerDetailsPage({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  State<PlayerDetailsPage> createState() =>
      _PlayerDetailsPageState(player: player);
}

class _PlayerDetailsPageState extends State<PlayerDetailsPage> {
  List<TagesData> categoryTages = CategoryTages.all;
  PlayersModel player;
  _PlayerDetailsPageState({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 70.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          4.0,
                        ),
                        topRight: Radius.circular(
                          4.0,
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 52.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(player.image.toString()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${player.name} ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '( ${player.position} )',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${player.map}'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'age: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${player.birthday!.toDate().difference(DateTime.now()).inDays ~/ -365}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: 'Description : ',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${player.description}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  child: Text(
                    '${player.description}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal[600],
                      fontWeight: FontWeight.w600,
                    ),
                    // maxLines: 5,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
