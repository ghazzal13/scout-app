import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/player_model.dart';
import 'package:scout/layout/pages/player_details.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int itemCount = PlayersCubit.get(context).players.length;
    List<PlayersModel> items = PlayersCubit.get(context).players;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Go Back"),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
            padding: EdgeInsets.all(w / 30),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) =>
                buildItem(items[index], context)),
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

class SlideAnimation3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Go Back"),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 2500),
                  child: Container(
                    margin: EdgeInsets.only(bottom: w / 20),
                    height: w / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


/*
  {
            //
            //
            //
            //
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 200),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 2500),
                  child: Container(
                    //
                    //
                    //
                    //
                    margin: EdgeInsets.only(bottom: w / 20),
                    height: w / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Column(
                            children: const [
                              Text('data'),
                              Text('data'),
                              Text('data'),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.width * .40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(
                                  'https://recentlyheard.com/wp-content/uploads/2020/04/Lionel-Messi.jpg',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
      

      */