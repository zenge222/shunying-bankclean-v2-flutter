import 'dart:convert';
import 'dart:io';

import 'package:bank_clean_flutter/main.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 网络请求封装，包含常用地post和get
class HttpServe {
//  static const String BASE_URL = 'http://propertyapi.omnrj.com/';
  static const String BASE_URL = 'http://192.168.1.7:8111/';

  ///url=请求地址，map把参数存map里面往里面塞，没有参数就不传
  static Future<String> get(String url, {Map map}) async {
    Dio dio = new Dio();

    ///请求option
    Map<String, dynamic> headerMap = new Map();
    String token = await SharedPreferencesUtil.getToken();
    headerMap['Authorization'] = token;
    Options option =
        new Options(responseType: ResponseType.plain, headers: headerMap);

    ///拼接数据
    String dataStr = '';
    if (map != null && map.isNotEmpty) {
      map.forEach((key, value) =>
          {dataStr = dataStr + key + '=' + value.toString() + "&"});
      dataStr.replaceRange(dataStr.length - 2, dataStr.length - 1, '');
    }
    if (dataStr != '') {
      print(BASE_URL + url + '?' + dataStr);
    } else {
      print(BASE_URL + url);
    }
    Response response;

    ///请求错误捕捉
    try {
      response = await dio.get(BASE_URL + url + '?' + dataStr, options: option);
      /// token 失效
      if (json.decode(response.data)['code'] == 1001) {
        Router.navigatorKey.currentState
            .pushNamedAndRemoveUntil("/login", ModalRoute.withName("/"));
        SharedPreferencesUtil.clear();
        Fluttertoast.showToast(
          msg: '登录已过期',
          fontSize: 15,
          gravity: ToastGravity.CENTER,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: '网络异常',
        fontSize: 15,
        gravity: ToastGravity.CENTER,
      );
      print('接口请求错误: $e');
    }
    return response.data.toString();
  }

  ///url=请求地址，formData=post请求body，map=kay-value参数，没有参数就不传
  static Future<String> post(String url, {Object formData, Map map}) async {
    print(BASE_URL + url);
    Dio dio = new Dio();

    ///请求option
    Map<String, dynamic> headerMap = new Map();
    String token = await SharedPreferencesUtil.getToken();
    headerMap['Authorization'] = token;
    Options option =
        new Options(responseType: ResponseType.plain, headers: headerMap);

    ///拼接数据
    String dataStr = '';
    if (map != null && map.isNotEmpty) {
      map.forEach((key, value) =>
          {dataStr = dataStr + key + '=' + value.toString() + "&"});
      dataStr.replaceRange(dataStr.length - 2, dataStr.length - 1, '');
    }
    print(BASE_URL + url + dataStr);
    Response response;

    ///请求错误捕捉
    try {
      if (formData != null) {
        response = await dio.post(
            BASE_URL + url + (dataStr == '' ? '' : ('?' + dataStr)),
            data: formData,
            options: option);
      } else {
        response = await dio.post(
            BASE_URL + url + (dataStr == '' ? '' : ('?' + dataStr)),
            options: option);
      }
      /// token 失效
      if (json.decode(response.data)['code'] == 1001) {
        Router.navigatorKey.currentState
            .pushNamedAndRemoveUntil("/login", ModalRoute.withName("/"));
        SharedPreferencesUtil.clear();
        Fluttertoast.showToast(
          msg: '登录已过期',
          fontSize: 15,
          gravity: ToastGravity.CENTER,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: '网络异常',
        fontSize: 15,
        gravity: ToastGravity.CENTER,
      );
      print('接口请求错误: $e');
    }
    return response.data.toString();
  }

  static Future uploadFile(url, String filePath) async {
    print(BASE_URL + url);

    Dio dio = new Dio();

    ///请求option
    Map<String, dynamic> headerMap = new Map();
    String token = await SharedPreferencesUtil.getToken();
    headerMap['Authorization'] = token;
    Options option =
        new Options(responseType: ResponseType.plain, headers: headerMap);

    try {
      var name =
          filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
      FormData formData = FormData.fromMap(
          {"filename": await MultipartFile.fromFile(filePath, filename: name)});
      var response = await dio.post<String>(BASE_URL + url,
          data: formData, options: option);
      /// token 失效
      if (json.decode(response.data)['code'] == 1001) {
        Router.navigatorKey.currentState
            .pushNamedAndRemoveUntil("/login", ModalRoute.withName("/"));
        SharedPreferencesUtil.clear();
        Fluttertoast.showToast(
          msg: '登录已过期',
          fontSize: 15,
          gravity: ToastGravity.CENTER,
        );
      }
      if (response.statusCode == 200) {
        return json.decode(response.data);
      } else {
        throw Exception("后台接口异常");
      }
    } catch (e) {
      return print("error:=======>${e}");
    }
  }
}
