

import 'package:get_storage/get_storage.dart';

class StorageKey {
  StorageKey._internal();
  static final StorageKey _instance = StorageKey._internal();
  static StorageKey get instance => _instance;

  static const cop = "COP";
  static const findPath = "findPath";
  static const findNew = "findNew";
  static const wordColor = "wordColor";


  setStorage({key, msg}){
    final storage = GetStorage();
    storage.write(key, msg);
  }

  getStorage({key}){
    final storage = GetStorage();
    return storage.read(key);
  }




}