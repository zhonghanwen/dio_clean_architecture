/**
 * 网络数据结果类
 */
class ResultData {
  var data;
  bool result;
  int code;
  var headers;
  String msg;

  ResultData(this.data, this.result, this.code, {this.headers, this.msg});
}