import 'dart:ui';

import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:scout/app_theme.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/models/player_model.dart';
import 'package:scout/layout/pages/player_details.dart';
import 'package:scout/layout/widgets/player_widgets/tages_data.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.position}) : super(key: key);
  final String position;
  @override
  State<PlayerPage> createState() => _PlayerPageState(
        position: position,
      );
}

class _PlayerPageState extends State<PlayerPage> {
  String foot = 'both';
  String nation = 'both';
  String position;
  int age = 55;
  bool Bool_filter = false;
  _PlayerPageState({
    required this.position,
  });

  static final List<Chose> _choses_1 = [
    Chose(id: 1, name: "African"),
    Chose(id: 2, name: "north African"),
  ];
  final _items1 = _choses_1
      .map((chose) => MultiSelectItem<Chose>(chose, chose.name))
      .toList();
  static final List<Chose> _choses_2 = [
    Chose(id: 25, name: "less 25 y-old"),
    Chose(id: 30, name: 'less 30 y-old'),
  ];
  final _items2 = _choses_2
      .map((chose) => MultiSelectItem<Chose>(chose, chose.name))
      .toList();
  static final List<Chose> _choses_3 = [
    Chose(id: 1, name: "left"),
    Chose(id: 2, name: "right"),
  ];
  final _items3 = _choses_3
      .map((chose) => MultiSelectItem<Chose>(chose, chose.name))
      .toList();

  List<PlayersModel> _filter_list = [];
  late List<PlayersModel> temp;
  late List<PlayersModel> oreginal_list;
  void filter() {
    _filter_list = oreginal_list;
    if (foot != 'both') {
      _filter_list = PlayersCubit.get(context)
          .players
          .where((element) => element.foot == foot)
          .toList();
    } else {
      _filter_list = PlayersCubit.get(context).players;
    }

    temp = _filter_list;
    if (nation == 'both') {
      _filter_list = temp;
    } else {
      _filter_list = temp.where((element) => element.nation == nation).toList();
    }

    temp = _filter_list;

    if (age == 50) {
      _filter_list = temp;
    } else {
      _filter_list = temp
          .where((element) =>
              element.birthday.difference(DateTime.now()).inDays / -365 < age)
          .toList();
    }
    setState(() {
      _filter_list;
    });
  }

  var net = true;
  Future Net() async {
    var x = await DataConnectionChecker().hasConnection;
    if (x == false) {
      setState(() {
        net = x;
      });
    }
  }

  Future<void> getPlayers() async {
    await PlayersCubit.get(context).getAllPosts(position);
  }

  @override
  void initState() {
    getPlayers().then((value) {
      _filter_list = PlayersCubit.get(context).players;
      oreginal_list = PlayersCubit.get(context).players;
    });

    Net();

    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Go Back"),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: Image.asset(
              'assets/images/list.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          net
              ? !Bool_filter
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('players')
                          .where('type', isEqualTo: position)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 30),
                                  Icon(Icons.remove_shopping_cart_outlined,
                                      size: 100),
                                  SizedBox(height: 30),
                                  Text(
                                    "ther is no players datat reigh now",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 100)
                                ]),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return buildItemForStream(
                              context,
                              snapshot.data!.docs[index].data(),
                            );
                          },
                        );
                      })
                  : _filter_list.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.all(size.width / 30),
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: _filter_list.length,
                          itemBuilder: (context, index) {
                            return buildItem(_filter_list[index], context);
                          })
                      : Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 30),
                                Icon(Icons.remove_shopping_cart_outlined,
                                    color: Colors.white, size: 100),
                                SizedBox(height: 30),
                                Text(
                                  "you don't have any items in shopping cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 100)
                              ]),
                        )
              : Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.wifi_off,
                          size: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Please Check your Internet Connection'),
                        SizedBox(
                          height: 100,
                        )
                      ]),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Bool_filter = true;
            foot = 'both';
            nation = 'both';
            age = 55;
          });
          scaffoldKey.currentState
              ?.showBottomSheet((ctx) => _buildBottomSheet(ctx));
        },
        child: const Icon(
          Icons.filter_list_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            MultiSelectChipField(
              items: _items1,
              title: const Text('nationalete',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  nation = 'both';
                } else {
                  if (v.length == 1) {
                    nation = v.cast<Chose>().elementAt(0).name;
                  }
                  if (v.length > 1) {
                    nation = 'both';
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            MultiSelectChipField(
              items: _items2,
              title: const Text(
                'age',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  age = 50;
                } else {
                  if (v.length == 1) {
                    age = v.cast<Chose>().elementAt(0).id;
                  }
                  if (v.length > 1) {
                    age = 30;
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            MultiSelectChipField(
              items: _items3,
              title: const Text(
                'foot',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  foot = 'both';
                } else {
                  if (v.length == 1) {
                    foot = v.cast<Chose>().elementAt(0).name;
                  }
                  if (v.length > 1) {
                    foot = 'both';
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: AnimatedButton(
                color: primaryColor,
                height: 60,
                width: 120,
                shadowDegree: ShadowDegree.light,
                enabled: true,
                shape: BoxShape.rectangle,
                onPressed: () {
                  setState(() {
                    filter();
                  });

                  Navigator.pop(context);
                },
                child: const Text(
                  "Applay",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBottomSheet2(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            MultiSelectChipField(
              items: _items1,
              title: const Text('nationalete',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  nation = 'both';
                } else {
                  if (v.length == 1) {
                    nation = v.cast<Chose>().elementAt(0).name;
                  }
                  if (v.length > 1) {
                    nation = 'both';
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            MultiSelectChipField(
              items: _items2,
              initialValue: _items2,
              title: const Text(
                'age',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  age = 50;
                } else {
                  if (v.length == 1) {
                    age = v.cast<Chose>().elementAt(0).id;
                  }
                  if (v.length > 1) {
                    age = 30;
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            MultiSelectChipField(
              items: _items3,
              title: const Text(
                'foot',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              headerColor: primaryColor,
              selectedTextStyle: const TextStyle(color: primaryColor),
              onTap: (v) {
                if (v.isEmpty) {
                  foot = 'both';
                } else {
                  if (v.length == 1) {
                    foot = v.cast<Chose>().elementAt(0).name;
                  }
                  if (v.length > 1) {
                    foot = 'both';
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: AnimatedButton(
                color: primaryColor,
                height: 60,
                width: 120,
                shadowDegree: ShadowDegree.light,
                enabled: true,
                shape: BoxShape.rectangle,
                onPressed: () {
                  setState(() {
                    filter();
                  });

                  Navigator.pop(context);
                },
                child: const Text(
                  "Applay",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildItemForStream(context, snap) => InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerDetailsPage(
              player: PlayersModel(
            id: snap['id'].toString(),
            description: snap['description'].toString(),
            position: snap['position'].toString(),
            birthday: DateTime.parse(snap['birthday'].toDate().toString()),
            name: snap['name'].toString(),
            image: snap['image'].toString(),
            foot: snap['foot'].toString(),
            nation: snap['nation'].toString(),
            country: snap['country'].toString(),
            map: snap['map'].toString(),
          )),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
          child: SizedBox(
            height: 150.0,
            child: Center(
              child: Row(
                children: [
                  Container(
                    width: 120.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(snap['image'].toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              snap['name'].toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'age: ',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${snap['birthday'].toDate().difference(DateTime.now()).inDays ~/ -365}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' years,',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ${DateFormat.yMd().format(snap['birthday'].toDate())} ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              snap['description'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));

Widget buildItem(PlayersModel items, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailsPage(
              player: items,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
            child: SizedBox(
              height: 150,
              child: Center(
                child: Row(
                  children: [
                    Container(
                      width: 120.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(items.image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 120.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                items.name.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'age: ',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${items.birthday.difference(DateTime.now()).inDays ~/ -365}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' years,',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '  ${DateFormat.yMd().format(items.birthday)} ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              items.description.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
