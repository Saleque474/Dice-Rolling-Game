import 'package:dice_game/knockout.dart';
import 'package:flutter/material.dart';

import 'dice.dart';

void main() {
  runApp(DiceGameApp());
}

class DiceGameApp extends StatelessWidget {
  const DiceGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KnockoutGame(),
    );
  }
}
