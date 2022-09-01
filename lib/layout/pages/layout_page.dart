import 'package:flutter/material.dart';

import '../widgets/layout_widgets/attack_line.dart';
import '../widgets/layout_widgets/defense_line.dart';
import '../widgets/layout_widgets/midfield.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
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
