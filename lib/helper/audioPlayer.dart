
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
  }

  playCardFlip(filename){
    cardFlipPlayer.setAsset(filename);
    cardFlipPlayer.play();
    // cardFlipPlayer.dispose();
  }

  playBg(filename, low){
    bgPlayer = AudioPlayer();
    bgPlayer.setAsset(filename);
    bgPlayer.play();
    bgPlayer.setLoopMode(LoopMode.all);
    if(low){
      bgPlayer.setVolume(0.2);
    }else{
      bgPlayer.setVolume(0.3);
    }
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