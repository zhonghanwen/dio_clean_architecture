import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_clean/net/ResultData.dart';
import 'package:dio_clean/net/StatusCode.dart';



class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async{
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData(StatusCode.errorHandleFunction(StatusCode.NETWORK_ERROR, "", false), false, StatusCode.NETWORK_ERROR));
    }
    return options;
  }
}