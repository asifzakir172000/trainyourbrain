import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';

class TimeCountDown extends StatelessWidget {

  final height;
  final width;

  const TimeCountDown({
    Key? key,
    this.height = 40.0,
    this.width = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,),
      child: CircularCountDownTimer(
        width: width,
        height: height,
        duration: 4,
        fillColor: Colors.amber,
        ringColor: Colors.white,
        backgroundColor: Colors.amber,
        strokeWidth: 5.0,
        isReverse: true,
        strokeCap: StrokeCap.round,
        textFormat: CountdownTextFormat.S,
        isTimerTextShown: true,
        textStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        onStart: () {
          AudioPlayerClass.instance.play(timerAudio);
        },
        onComplete: () {
          AudioPlayerClass.instance.dismiss();
        },
      ),
    );
  }
}
