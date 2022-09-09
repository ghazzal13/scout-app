import 'dart:convert';

class PlayersModel {
  final String? name;

  final String? id;
  final String? image;
  final String? con;
  final String? dis;
  final String? pos;
  final String? birthdate;

  const PlayersModel({
    required this.id,
    required this.dis,
    required this.pos,
    required this.birthdate,
    required this.name,
    required this.image,
    required this.con,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'image': image,
      'con': con,
      'dis': dis,
      'pos': pos,
      'birthdate': birthdate,
    };
  }

  factory PlayersModel.fromMap(Map<String, dynamic> map) {
    return PlayersModel(
      name: map['name'],
      id: map['id'],
      image: map['image'],
      con: map['con'],
      dis: map['dis'],
      pos: map['pos'],
      birthdate: map['birthdate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersModel.fromJson(String source) =>
      PlayersModel.fromMap(json.decode(source));
}
