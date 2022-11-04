import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:scout/layout/widgets/player_widgets/tages_data.dart';

List<TagesData> categoryTages = CategoryTages.all;

Widget buildtTags() => Wrap(
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
                  textScaleFactor:
                      utf8.encode(categoryTages.label.substring(0, 1)).length >
                              2
                          ? 0.8
                          : 1,
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  onPressed: (categoryTages) {},
                );
              },
            ))
        .toList());
