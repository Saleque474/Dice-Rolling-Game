import 'package:dice_game/dice.dart';
import 'package:flutter/material.dart';

TextStyle textStyle1 = TextStyle(color: Color(0xFF5AD68E));
Color button = Color(0xFF9E5954);
Color text = Color(0xFF5AD68E);
Color background = Colors.black87;

class KnockoutGame extends StatefulWidget {
  const KnockoutGame({Key? key}) : super(key: key);

  @override
  _KnockoutGameState createState() => _KnockoutGameState();
}

class _KnockoutGameState extends State<KnockoutGame> {
  Dice? dice1;
  Dice? dice2;
  double _palyerScore = 0;
  double _machineScore = 0;
  String _turn = "";
  String _recentPlSc = "";
  String _recentMachineSc = "";
  String _notification = "";
  bool _running = false;

  void showMessage(BuildContext context, String notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF415248),
          width: double.infinity,
          height: 200,
          child: Center(
            child: Text(
              notification,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: text, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    dice1 = Dice();
    dice2 = Dice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Color(0xFF613A29),
        title: Text(
          "Dice Rolling Game",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
                child: dice1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
                child: dice2,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(_turn, textAlign: TextAlign.center, style: textStyle1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Player",
                style: textStyle1,
              ),
              Text(
                "Machine",
                style: textStyle1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Text(_recentPlSc,
                    textAlign: TextAlign.center, style: textStyle1),
              ),
              SizedBox(
                child: Text(_recentMachineSc,
                    textAlign: TextAlign.center, style: textStyle1),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$_palyerScore",
                style: textStyle1,
              ),
              Text(
                "$_machineScore",
                style: textStyle1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Color(0xFF9E5954),
                onPressed: _running
                    ? null
                    : () async {
                        setState(() {
                          _running = true;
                        });
                        setState(() {
                          _turn = " Player's Dice Rolling";
                        });
                        double plResult =
                            await dice1!.play() + await dice2!.play();
                        setState(() {
                          _recentPlSc = "Recent: $plResult";
                        });

                        if (plResult == 7) plResult = 0;
                        await Future.delayed(Duration(seconds: 2));
                        setState(() {
                          _turn = " Machine's Dice Rolling";
                        });
                        double mnResult =
                            await dice1!.play() + await dice2!.play();
                        setState(() {
                          _recentMachineSc = "Recent : $mnResult";
                        });
                        if (mnResult == 7) mnResult = 0;

                        setState(() {
                          _palyerScore += plResult;
                          _machineScore += mnResult;
                        });
                        setState(() {
                          _turn = " ";
                        });
                        if (_machineScore >= 50 || _palyerScore >= 50) {
                          if (_machineScore > _palyerScore) {
                            setState(() {
                              _notification = "You lose";
                            });
                          } else if (_machineScore == _palyerScore) {
                            setState(() {
                              _notification = "Draw Match";
                            });
                          } else {
                            setState(() {
                              _notification = "You Won";
                            });
                          }
                          showMessage(context, _notification);
                          _machineScore = 0;
                          _palyerScore = 0;
                        }
                        setState(() {
                          _running = false;
                        });
                      },
                child: Text(
                  "Play",
                  style: textStyle1,
                ),
              ),
              MaterialButton(
                color: Color(0xFF9E5954),
                onPressed: () {
                  setState(() {
                    _machineScore = 0;
                    _palyerScore = 0;
                  });
                },
                child: Text(
                  "Restart",
                  style: textStyle1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
