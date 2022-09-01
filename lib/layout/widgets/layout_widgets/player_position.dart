import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:scout/layout/pages/players_page.dart';

Widget playerContainer(
  String name,
  var width,
) =>
    OpenContainer(
        transitionDuration: const Duration(milliseconds: 400),
        closedBuilder: (_, openContainer) {
          return SizedBox(
            height: width,
            width: width,
            child: TextButton(
              onPressed: openContainer,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        openColor: Colors.white,
        closedElevation: 10.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        closedColor: Colors.white,
        openBuilder: (_, closeContainer) {
          return const PlayerPage();

          // return Scaffold(
          //   appBar: AppBar(
          //     backgroundColor: Colors.blue,
          //     title: const Text('Go back'),
          //     leading: IconButton(
          //       onPressed: closeContainer,
          //       icon: const Icon(Icons.arrow_back, color: Colors.white),
          //     ),
          //   ),
          // );
        });
