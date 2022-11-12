import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/player_model.dart';
import 'package:scout/cubit/states.dart';
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

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  String foot = 'both';
  String nation = 'both';
  String position;
  int age = 25;
  _PlayerPageState({
    required this.position,
  });

  static final List<Chose> _choses_1 = [
    Chose(id: 1, name: "african"),
    Chose(id: 2, name: "north african"),
  ];
  final _items1 = _choses_1
      .map((chose) => MultiSelectItem<Chose>(chose, chose.name))
      .toList();
  static final List<Chose> _choses_2 = [
    Chose(id: 25, name: "'less 25 y-old'"),
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
  void filter() {
    if (foot != 'both') {
      _filter_list = PlayersCubit.get(context)
          .players
          .where((element) => element.foot == foot)
          .toList();
    } else {
      _filter_list = PlayersCubit.get(context).players;
    }
    print(_filter_list);
    print('111111111111111111111111111111111111111');
    temp = _filter_list;
    if (nation == 'both') {
      _filter_list = temp;
    } else {
      _filter_list = temp.where((element) => element.nation == nation).toList();
    }
    print(_filter_list);
    print('22222222222222222222222222222222222222222222');
    temp = _filter_list;

    if (age == 50) {
      _filter_list = temp;
    } else {
      _filter_list = temp
          .where((element) =>
              element.birthday!.toDate().difference(DateTime.now()).inDays /
                  -365 <
              age)
          .toList();
    }
    print(_filter_list);
    print('3333333333333333333333333333333333333333333');
    setState(() {
      _filter_list;
    });
  }

  Future<void> getPlayers() async {
    await PlayersCubit.get(context).getAllPosts(position);
  }

  @override
  void initState() {
    getPlayers().then((value) {
      _filter_list = PlayersCubit.get(context).players;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayersCubit, PlayersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double w = MediaQuery.of(context).size.width;

        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Go Back"),
          ),
          body: (_filter_list.isEmpty)
              ? Center(
                  child: Column(
                  children: const [
                    Icon(Icons.data_array),
                    Text('they no players data'),
                  ],
                ))
              : ListView.builder(
                  padding: EdgeInsets.all(w / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: _filter_list.length,
                  itemBuilder: (context, index) {
                    return buildItem(_filter_list[index], context);
                  }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => scaffoldKey.currentState
                ?.showBottomSheet((ctx) => _buildBottomSheet(ctx)),
            child: const Icon(
              Icons.filter_list_rounded,
              size: 40,
            ),
          ),
        );
      },
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            MultiSelectChipField(
              items: _items1,
              title: const Text('nationalete',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  )),
              headerColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: TextStyle(color: Colors.blue[800]),
              onTap: (v) {
                if (v.isEmpty) {
                  nation = 'both';

                  print(nation);
                } else {
                  if (v.length == 1) {
                    nation = v.cast<Chose>().elementAt(0).name;

                    print(nation);
                  }
                  if (v.length > 1) {
                    nation = 'both';

                    print(nation);
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
                ),
              ),
              headerColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: TextStyle(color: Colors.blue[800]),
              onTap: (v) {
                if (v.isEmpty) {
                  age = 50;

                  print(age);
                } else {
                  if (v.length == 1) {
                    age = v.cast<Chose>().elementAt(0).id;

                    print(age);
                  }
                  if (v.length > 1) {
                    age = 30;

                    print(age);
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
                ),
              ),
              headerColor: Colors.blue.withOpacity(0.5),
              selectedTextStyle: TextStyle(color: Colors.blue[800]),
              onTap: (v) {
                if (v.isEmpty) {
                  foot = 'both';

                  print(foot);
                } else {
                  if (v.length == 1) {
                    foot = v.cast<Chose>().elementAt(0).name;

                    print(foot);
                  }
                  if (v.length > 1) {
                    foot = 'both';

                    print(foot);
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: AnimatedButton(
                height: 60,
                width: 120,
                shadowDegree: ShadowDegree.light,
                enabled: true,
                shape: BoxShape.rectangle,
                onPressed: () {
                  setState(() {
                    filter();
                  });
                  print('ddddddddddddddddddddddddddd');
                  print(_filter_list);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Applay",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        items.name.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      items.description.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
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
    );
