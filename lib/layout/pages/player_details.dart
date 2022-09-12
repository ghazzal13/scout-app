import 'package:flutter/material.dart';

import 'package:scout/cubit/player_model.dart';

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
  PlayersModel player;
  _PlayerDetailsPageState({required this.player});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child:
                //image

                Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${player.image}'),
                    ),
                  ),
                ),
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
                          'Name: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${player.name}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'position: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${player.pos}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                          '${player.birthdate}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                        '${player.dis}',
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

              //name

              //age

              //cauntry

              //pos

              //foot

              //dis

              //link YouTube
            ),
          )),
    );
  }
}
