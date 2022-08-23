
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerClass {

  AudioPlayerClass._internal();
  static final AudioPlayerClass _instance = AudioPlayerClass._internal();
  static AudioPlayerClass get instance => _instance;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer bgPlayer = AudioPlayer();

  play(filename){
    debugPrint("file name: $filename");
    audioPlayer.setAsset(filename);
    audioPlayer.play();
    audioPlayer.loopMode;
  }

  playBg(filename){
    bgPlayer.setAsset(filename);
    bgPlayer.play();
    bgPlayer.setLoopMode(LoopMode.all);
    bgPlayer.setVolume(0.3);
  }

  dismiss(){
    audioPlayer.dispose();
  }

  dismissBgPlayer(){
    bgPlayer.stop();
  }

  restartBg(){
    bgPlayer.play();
  }


}