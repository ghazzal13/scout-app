import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scout/layout/pages/settings_screen.dart';
import 'package:scout/layout/widgets/reuse_widget.dart';

import '../widgets/layout_widgets/attack_line.dart';
import '../widgets/layout_widgets/defense_line.dart';
import '../widgets/layout_widgets/midfield.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  Future<void> netCheck() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == false) {
      showSnackBar(context, 'You Don\'t Have Internet Connection');
    }
  }

  @override
  void initState() {
    netCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('  Positions'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: Image.asset(
              'assets/images/ground_2.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                SizedBox(height: 5),
                AttackLine(),
                MidfieldPleyers(),
                DefenseLine(),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
