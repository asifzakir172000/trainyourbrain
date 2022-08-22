import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'dart:async';
import 'package:trainyourbrain/view/card/cardData.dart';

class FlipCardScreen extends StatefulWidget {
  final int? number;
  const FlipCardScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<FlipCardScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;

  bool _wait = false;
  Timer? _timer;
  int? _time;
  int? _left;
  bool? _isFinished;
  List<String>? _data;

  List<bool>? _cardFlips;
  List<GlobalKey<FlipCardState>>? _cardStateKeys;

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
             BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(4.0),
      child: Image.asset(_data![index]),
    );
  }

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = _time! - 1;
      });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray(widget.number!);
    _cardFlips = getInitialItemState(widget.number!);
    _cardStateKeys = getCardStateKeys(widget.number!);
    _time = 3;
    _left = (_data!.length ~/ 2);

    _isFinished = false;
    Future.delayed(const Duration(seconds: 3), () {
      if(!mounted){
        setState(() {
          _start = true;
          _timer!.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    restart();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished!
        ? Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You win the Game!!\nCongratulations",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  restart();
                });
              },
              child: Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  "Replay",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        : Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Match the Correct Pair of cards",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _time! > 0
                    ? Text(
                  '$_time',
                  style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
                    : Text(
                  'Card left:$_left',
                  style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => _start
                      ? FlipCard(
                      key: _cardStateKeys![index],
                      onFlip: () {
                        debugPrint("onflip, $_flip");
                        if (!_flip) {
                          _flip = true;
                          _previousIndex = index;
                        } else {
                          _flip = false;
                          debugPrint(
                              "onflip1, $_flip, index ($_previousIndex , $index)");
                          if (_previousIndex != index) {
                            if (_data![_previousIndex] !=
                                _data![index]) {
                              _wait = true;

                              Future.delayed(
                                  const Duration(milliseconds: 1500),
                                      () {
                                    _cardStateKeys![_previousIndex]
                                        .currentState!
                                        .toggleCard();

                                    _previousIndex = index;

                                    _cardStateKeys![_previousIndex]
                                        .currentState!
                                        .toggleCard();

                                    Future.delayed(
                                        const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _wait = false;
                                          });
                                        });
                                  });
                            } else {
                              _cardFlips![_previousIndex] = false;
                              _cardFlips![index] = false;
                              setState(() {
                                _left = _left! - 1;
                              });
                              if (_cardFlips!
                                  .every((t) => t == false)) {
                                Future.delayed(
                                    const Duration(milliseconds: 160),
                                        () {
                                      setState(() {
                                        _isFinished = true;
                                        _start = false;
                                      });
                                    });
                              }
                            }
                          }
                        }
                        setState(() {});
                      },
                      flipOnTouch: _wait ? false : _cardFlips![index],
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                               BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                spreadRadius: 0.8,
                                offset: Offset(2.0, 1),
                              )
                            ]),
                        margin: const EdgeInsets.all(4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            questionMarkImage,
                          ),
                        ),
                      ),
                      back: getItem(index))
                      : getItem(index),
                  itemCount: _data!.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
