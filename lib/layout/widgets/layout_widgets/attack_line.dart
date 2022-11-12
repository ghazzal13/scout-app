import 'package:flutter/widgets.dart';
import 'package:scout/layout/widgets/layout_widgets/player_position.dart';

class AttackLine extends StatefulWidget {
  const AttackLine({Key? key}) : super(key: key);

  @override
  State<AttackLine> createState() => _AttackLineState();
}

class _AttackLineState extends State<AttackLine> {
  @override
  Widget build(BuildContext context) {
    return playerContainer('Forward',
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .2,
        position: 'Forward');
  }
}
