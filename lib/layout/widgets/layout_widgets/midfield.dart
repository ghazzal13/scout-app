import 'package:flutter/cupertino.dart';
import 'package:scout/layout/widgets/layout_widgets/player_position.dart';

class MidfieldPleyers extends StatefulWidget {
  const MidfieldPleyers({Key? key}) : super(key: key);

  @override
  State<MidfieldPleyers> createState() => _MidfieldPleyersState();
}

class _MidfieldPleyersState extends State<MidfieldPleyers> {
  @override
  Widget build(BuildContext context) {
    return playerContainer('Midfielder',
        width: MediaQuery.of(context).size.width * .60,
        height: MediaQuery.of(context).size.height * .20,
        position: 'Midfielder');
  }
}
