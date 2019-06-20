
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_clean/net/ResultData.dart';
import 'package:dio_clean/net/StatusCode.dart';
import 'package:dio_clean/utils/DebugUtil.dart';


/**
 * 响应拦截器
 */
class ResponseInterceptors extends InterceptorsWrapper {

  @override
  onResponse(Response response) {
    if(DebugUtil.isDebugMode){
      print("[dio] data:" + response.data.toString());
    }
    RequestOptions option = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(response.data == null) {
            return new ResultData("", false, StatusCode.RESPONSE_DATA_IS_NULL, headers: response.headers);
        }
        var body = response.data['body'];
        var code = response.data['code'];
        var msg  = response.data['msg'];
        if(DebugUtil.isDebugMode){
          print("[dio] body:" + body.toString());
          print("[dio] code:" + code.toString());
          print("[dio] msg: " + msg.toString());
        }
        if(code == StatusCode.SUCCESS){
          return new ResultData(json.encode(body), true, StatusCode.SUCCESS, headers: response.headers, msg: msg);
        }else{
          return new ResultData(StatusCode.errorHandleFunction(code, msg, false), false, code, headers: response.headers);
        }
      }
    } catch (e) {
      print(e.toString() + option.path);
      return new ResultData(response.data, false, response.statusCode, headers: response.headers);
    }
  }
}