
import 'package:get/get.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/storageKey.dart';

class HomeController extends SuperController{

  var reasoningPer = 0.0.obs;
  var attentionPer = 0.0.obs;

  setData(){
    final reasoning = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0;
    final attention = StorageKey.instance.getStorage(key: StorageKey.attentionPer)??0;
    reasoningPer.value = calculatePer(reasoning, 15);
    attentionPer.value = calculatePer(attention, 5);
  }

  calculatePer(completeLevel, totalLevel){
    return completeLevel / totalLevel;
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  @override
  void onDetached() {

  }

  @override
  void onInactive() {

  }

  @override
  void onPaused() {
    AudioPlayerClass.instance.dismissBgPlayer();
  }

  @override
  void onResumed() {
    AudioPlayerClass.instance.restartBg();
  }

}