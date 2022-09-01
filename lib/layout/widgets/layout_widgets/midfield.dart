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
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          playerContainer('AMF', MediaQuery.of(context).size.width * .30),
          playerContainer('CMF', MediaQuery.of(context).size.width * .30),
          playerContainer('DMF', MediaQuery.of(context).size.width * .30),
        ],
      ),
    );
  }
}
