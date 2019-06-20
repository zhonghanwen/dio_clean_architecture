
class DebugUtil {

  static final bool isDebugMode = true;

  static debug(msg){
    if(isDebugMode){
      print(msg);
    }
  }

}