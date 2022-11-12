import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersModel {
  final String? name;

  final String? id;
  final String? image;
  final String? country;
  final String? description;
  final String? position;
  final String? foot;
  final String? map;
  final String? nation;
  final Timestamp? birthday;

  const PlayersModel({
    required this.id,
    required this.description,
    required this.position,
    required this.birthday,
    required this.name,
    required this.image,
    required this.foot,
    required this.nation,
    required this.country,
    required this.map,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'image': image,
      'country': country,
      'description': description,
      'position': position,
      'foot': foot,
      'nation': nation,
      'map': map,
      'birthday': birthday,
    };
  }

  factory PlayersModel.fromMap(Map<String, dynamic> map) {
    return PlayersModel(
      name: map['name'],
      id: map['id'],
      image: map['image'],
      country: map['country'],
      description: map['description'],
      position: map['position'],
      foot: map['foot'],
      nation: map['nation'],
      birthday: map['birthday'],
      map: map['map'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersModel.fromJson(String source) =>
      PlayersModel.fromMap(json.decode(source));
}
