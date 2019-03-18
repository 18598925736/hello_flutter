import 'package:dio/dio.dart';
import 'data_manager.dart';

///第三方网络库，必须封装，这是铁则
class HttpManager {
  Dio _dio;
  static HttpManager _instance;

  //用工厂模式做一个单例
  factory HttpManager.getInstance() {
    //工厂构造函数
    if (_instance == null) _instance = HttpManager._internal();
    return _instance;
  }

  HttpManager._internal() {
    //命名构造函数, 加了_表示私有
    BaseOptions options = new BaseOptions(
        baseUrl: DataManager.baseUrl, //基础地址前缀
        connectTimeout: 5000, //连接服务器超时时间
        receiveTimeout: 3000 //连上了服务器，但是返回超时时间
        );
    _dio = new Dio(options); //给dio加上基础配置
  }

  ///对外公开的方法
  request(url, {String method = 'get'}) async {
    print("请求的url是：" + url);
    try {
      Options options = new Options(method: method);
      Response response = await _dio.request(url, options: options);
      return response.data; //返回成功，则是map，失败，null
    } catch (e) {
      return null;
    }
  }
}