import 'package:flutter/cupertino.dart';
import 'package:scout/layout/widgets/layout_widgets/player_position.dart';

class DefenseLine extends StatefulWidget {
  const DefenseLine({Key? key}) : super(key: key);

  @override
  State<DefenseLine> createState() => _DefenseLineState();
}

class _DefenseLineState extends State<DefenseLine> {
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        playerContainer('LB', MediaQuery.of(context).size.width * .22),
        playerContainer('CB', MediaQuery.of(context).size.width * .22),
        playerContainer('CB', MediaQuery.of(context).size.width * .22),
        playerContainer('RB', MediaQuery.of(context).size.width * .22),
      ],
    );
  }
}
