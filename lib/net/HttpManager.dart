import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_clean/net/HttpApi.dart';
import 'package:dio_clean/net/ResultData.dart';
import 'package:dio_clean/net/StatusCode.dart';
import 'package:dio_clean/net/interceptors/ErrorInterceptors.dart';
import 'package:dio_clean/net/interceptors/HeaderInterceptors.dart';
import 'package:dio_clean/net/interceptors/LogsInterceptors.dart';
import 'package:dio_clean/net/interceptors/ResponseInterceptors.dart';
import 'package:dio_clean/net/interceptors/TokenInterceptors.dart';
import 'package:dio_clean/utils/DebugUtil.dart';


class HttpManager {

  Dio _dio = new Dio(); //使用默认配置

  String _baseUrl =  DebugUtil.isDebugMode ? HttpApi.debugBaseUrl : HttpApi.baseUrl;

  HttpManager(){

    //设置头部拦截器
    _dio.interceptors.add(new HeaderInterceptors());

    //设置Token拦截器
    _dio.interceptors.add(new TokenInterceptors()); 

    //设置错误拦截器
    _dio.interceptors.add(new ErrorInterceptors(_dio));

    //设置响应拦截器
    _dio.interceptors.add(new ResponseInterceptors());

    //设置日志拦截器
    _dio.interceptors.add(new LogsInterceptors());

    //设置信任Https证书
    _setCert();
  }

  _setCert(){
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      DebugUtil.debug("[dio] onHttpClientCreate");
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        DebugUtil.debug("[dio] badCertificateCallback " + host);
        return true;
      };
    };
  }

  Options _getOption() {
    return Options(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      contentType: ContentType.json,
      responseType: ResponseType.json,
    );
  }

  sendGetRequest(url, params, Map<String, dynamic> header,  {CancelToken cancelToken, noTip = false}) async{
      Options baseOptions = _getOption();
      baseOptions.method = "GET";
      return await request(_baseUrl + url, params, header, baseOptions, cancelToken: cancelToken, noTip: noTip);
  }

  sendPostRequest(url, params, Map<String, dynamic> header, {CancelToken cancelToken, noTip = false}) async{
      Options baseOptions = _getOption();
      baseOptions.method = "POST";
      return await request(_baseUrl + url, params, header, baseOptions, cancelToken: cancelToken, noTip: noTip);
  }

  request(url, params, Map<String, dynamic> header, Options option,  {CancelToken cancelToken, noTip = false}) async {
    
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "GET");
      option.headers = headers;
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option, cancelToken: cancelToken);
    } on DioError catch (e) {
      return _resultError(e);
    }
    if(response.data is DioError) {
      return _resultError(response.data);
    }
    return response?.data;
  }

  _resultError(DioError e, {noTip = false}) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = StatusCode.NETWORK_TIME_OUT;
      }
      return new ResultData(StatusCode.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }
}

final HttpManager httpManager = new HttpManager();