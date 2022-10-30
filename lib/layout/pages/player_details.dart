import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

import 'package:scout/cubit/player_model.dart';
import 'package:scout/layout/widgets/player_widgets/tages_data.dart';
import 'package:scout/layout/widgets/reuse_widget.dart';

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
            children: [
              BuildA(),
              const SizedBox(
                height: 10,
              ),
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
                  const ActionChip(label: Text('data'))
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
          )),
    );
  }

  Widget BuildA() => Wrap(
      runSpacing: 5.0,
      spacing: 5.0,
      children: categoryTages
          .map((categoryTages) => Tags(
                    symmetry: false,
                    heightHorizontalScroll: 60 * (16 / 14),
                    itemCount: 1,
                    itemBuilder: (index) {
                      return ItemTags(
                        key: Key(index.toString()),
                        index: index,
                        title: categoryTages.label,
                        active: false,
                        pressEnabled: true,
                        activeColor: Colors.blueGrey[600],
                        singleItem: false,
                        combine: ItemTagsCombine.withTextBefore,
                        textScaleFactor: utf8
                                    .encode(categoryTages.label.substring(0, 1))
                                    .length >
                                2
                            ? 0.8
                            : 1,
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        onPressed: (categoryTages) {
                          showSnackBar(context,
                              '${categoryTages.title} is pressed right now');
                        },
                      );
                    },
                  )
              /*ActionChip(
              label: Text(categoryTages.label),
              backgroundColor: Colors.grey[500],
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              disabledColor: Colors.red,
              clipBehavior: Clip.hardEdge,
              onPressed: (() {
                showSnackBar(
                    context, '${categoryTages.label} is pressed right now');
                setState(() {});
              }),
            ),*/
              )
          .toList());
}
