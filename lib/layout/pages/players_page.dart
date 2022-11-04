import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/player_model.dart';
import 'package:scout/layout/pages/player_details.dart';
import 'package:scout/layout/widgets/player_widgets/tags.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int itemCount = PlayersCubit.get(context).players.length;
    List<PlayersModel> items = PlayersCubit.get(context).players;
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Go Back"),
      ),
      body: AnimationLimiter(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      buildItem(items[index], context),
                  childCount: itemCount),
            ),
          ],
          // children: [
          //   BuildtTags(),
          //   SingleChildScrollView(
          //     child: ListView.builder(
          //         padding: EdgeInsets.all(w / 30),
          //         physics: const BouncingScrollPhysics(
          //             parent: AlwaysScrollableScrollPhysics()),
          //         itemCount: itemCount,
          //         itemBuilder: (BuildContext context, int index) =>
          //             buildItem(items[index], context)),
          //   ),
          // ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scaffoldKey.currentState
            ?.showBottomSheet((ctx) => _buildBottomSheet(ctx)),
        child: const Icon(
          Icons.filter_list_rounded,
          size: 40,
        ),
      ),
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
            const Text(
              'nationalete',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'age',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'foot',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildtTags(),
            AnimatedButton(
              height: 60,
              width: 120,
              shadowDegree: ShadowDegree.light,
              enabled: true,
              shape: BoxShape.rectangle,
              onPressed: () {},
              child: const Text(
                "Applay",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
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
                      items.dis.toString(),
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
