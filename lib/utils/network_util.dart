import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();


  Future<dynamic> get(String url){
    return http.get(url).then((http.Response rsp){
      final String resp = rsp.body;
      final int statusCode = rsp.statusCode;

      if(statusCode < 200 || statusCode > 400 || json ==null){
        throw new Exception("Error fetching data");

      }

      return _decoder.convert(resp);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http.post(url, body: body, headers: headers, encoding: encoding).then((http.Response rsp){
      final String resp = rsp.body;
      final int statusCode = rsp.statusCode;

      if(statusCode < 200 || statusCode > 400 || json ==null){
        throw new Exception("Error fetching data");
      }
      return _decoder.convert(resp);
    });
  }
}// tutup kurawal paling duwur