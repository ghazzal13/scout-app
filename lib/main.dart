import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scout/cubit/cubit.dart';
import 'package:scout/cubit/states.dart';
import 'package:scout/layout/auth/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:scout/layout/pages/layout_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => PlayersCubit()..getAllPosts()),
      ],
      child: BlocConsumer<PlayersCubit, PlayersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return const LayoutPage();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const LoginPage();
                },
              ),
            );
          }),
    );
  }
}

// /*
// Platform  Firebase App Id
// web       1:453196205507:web:ece4328a98bff7691cc176
// android   1:453196205507:android:d687f1222ce85d1d1cc176
// ios       1:453196205507:ios:18deb9fdafe9ee041cc176
// macos     1:453196205507:ios:18deb9fdafe9ee041cc176

//  */
/*

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tags Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Tags'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;

  final List<String> _list = [
    'left foot',
    'right foot',
    'african',
    'north african',
    'less 25 y-old',
    'less 30 y-old',
  ];

  final bool _symmetry = false;
  final bool _removeButton = true;
  final bool _startDirection = false;
  final bool _horizontalScroll = true;
  final bool _withSuggesttions = false;
  final int _count = 0;
  final int _column = 0;

  final String _itemCombine = 'withTextBefore';

  final List _icon = [Icons.home, Icons.language, Icons.headset];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _scrollViewController = ScrollController();

    _items = _list.toList();
  }

  late List _items;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            _tags1,
          ])),
        ],
      ),
    );
  }

  Widget get _tags1 {
    return Tags(
      key: _tagStateKey,
      symmetry: false,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      heightHorizontalScroll: 60 * (16 / 14),
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          active: false,
          pressEnabled: true,
          activeColor: Colors.blueGrey[600],
          singleItem: false,
          combine: ItemTagsCombine.withTextBefore,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
          textStyle: const TextStyle(
            fontSize: 16,
          ),
          onPressed: (item) {
            
          },
        );
      },
    );
  }
}
*/