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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        playerContainer('LWF', MediaQuery.of(context).size.width * .25),
        playerContainer('CF', MediaQuery.of(context).size.width * .30),
        playerContainer('RWF', MediaQuery.of(context).size.width * .25),
      ],
    );
  }
}
