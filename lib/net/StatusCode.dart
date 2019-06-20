import 'event/EvevtBusManager.dart';
import 'event/HttpErrorEvent.dart';

class StatusCode {
  //网络错误
  static const NETWORK_ERROR = -1;

  //网络超时
  static const NETWORK_TIME_OUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  //参数错误
  static const PARAM_ERROR = 20001;

  //请求错误
  static const REQUEST_ERROR = 20002;

  //请求成功状态码
  static const SUCCESS = 200;

  //返回数据为空
  static const RESPONSE_DATA_IS_NULL = -4;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
