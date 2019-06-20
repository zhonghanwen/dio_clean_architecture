import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_clean/net/HttpApi.dart';
import 'package:dio_clean/net/HttpManager.dart';
import 'package:dio_clean/net/model/TestModel.dart';


class UserService {
  
  /**
   * 用户登录接口
   */
  static Future<TestModel> login({CancelToken cancelToken}) async {
    FormData formData = FormData.from({
      "phone": "18825195123",
      "request_time": "1111111111",
      "aid": "feafefessefiegeiefeef",
      "version": "1.0.0",
      "channel": "GP"
    });
    var res = await httpManager.sendPostRequest(
        HttpApi.userLogin, formData, null,
        cancelToken: cancelToken);
    if (res != null && res.result) {
      try {
        Map body1 = await json.decode(res.data);
        TestModel model = TestModel.fromJson(body1);
        return model;
      } catch (error) {
        throw Exception(error);
      }
    } else {
      return null;
    }
  }
}
