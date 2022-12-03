import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:scout/layout/pages/players_list_page.dart';

Widget playerContainer(String name,
        {var width, var height, required String position}) =>
    OpenContainer(
        transitionDuration: const Duration(milliseconds: 50),
        closedBuilder: (_, openContainer) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 70, sigmaX: 50),
            child: SizedBox(
              height: height,
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
            ),
          );
        },
        closedElevation: 10.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        openBuilder: (_, closeContainer) {
          return PlayerPage(position: position);
        });
