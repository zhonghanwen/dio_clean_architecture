
import 'package:dio/dio.dart';
import 'package:dio_clean/utils/DebugUtil.dart';

/**
 * 日志拦截器
 */
class LogsInterceptors extends InterceptorsWrapper{

  @override
  onRequest(RequestOptions options) {
    if(DebugUtil.isDebugMode){
      print("[dio] url:${options.path}");
      print('[dio] 请求头: ' + options.headers.toString());
      if (options.data != null) {
        print('[dio] 请求参数: ' + options.data.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if(DebugUtil.isDebugMode){
      if(response != null){
        print("[dio] 请求返回参数：${response.toString()}");
      }
    }
    return response;
  }

  @override
  onError(DioError err) {
    if(DebugUtil.isDebugMode){
      print("[dio] 请求异常：${err.toString()}");
      print("[dio] 请求异常信息：${err.response?.toString() ?? ""}");
    }
    return err;
  }
}