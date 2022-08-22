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

  play(filename){
    debugPrint("file name: $filename");
    const audioAsset = "assets/audio/beep.mp3";
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setAsset(audioAsset);
  }

}