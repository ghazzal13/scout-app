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
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('  Data'),
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
      body: Column(
        children: const [
          AttackLine(),
          MidfieldPleyers(),
          DefenseLine(),
        ],
      ),
    );
  }
}
