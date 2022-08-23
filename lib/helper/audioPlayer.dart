//
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerClass {
//
//   AudioPlayerClass._internal();
//   static final AudioPlayerClass _instance = AudioPlayerClass._internal();
//   static AudioPlayerClass get instance => _instance;
//
//   play(filename){
//     debugPrint("file name: $filename");
//     const audioAsset = "assets/audio/beep.mp3";
//     AudioPlayer audioPlayer = AudioPlayer();
//     audioPlayer.setSource(AssetSource(filename));
//   }
//
// }



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
    debugPrint("file name: $filename");
    bgPlayer.setAsset(filename);
    bgPlayer.play();
    bgPlayer.setLoopMode(LoopMode.all);
  }

  dismiss(){
    audioPlayer.dispose();
  }

  dismissBgPlayer(){
    bgPlayer.dispose();
  }

}