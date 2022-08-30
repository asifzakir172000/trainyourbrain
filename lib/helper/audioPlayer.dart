
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerClass {

  AudioPlayerClass._internal();
  static final AudioPlayerClass _instance = AudioPlayerClass._internal();
  static AudioPlayerClass get instance => _instance;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer bgPlayer = AudioPlayer();
  AudioPlayer cardFlipPlayer = AudioPlayer();

  play(filename) async {
    await audioPlayer.setAsset(filename);
    audioPlayer.play();
    // Future.delayed(const Duration(seconds: 8),(){
    //   audioPlayer.dispose();
    // });
  }

  playCardFlip(filename){
    cardFlipPlayer.setAsset(filename);
    cardFlipPlayer.play();
    // cardFlipPlayer.dispose();
  }

  playBg(filename){
    bgPlayer.setAsset(filename);
    bgPlayer.setVolume(0.3);
    bgPlayer.play();
    bgPlayer.setLoopMode(LoopMode.all);
  }

  dismiss(){
    audioPlayer.stop();
  }

  dismissBgPlayer(){
    bgPlayer.stop();
  }

  restartBg(){
    bgPlayer.play();
  }


}