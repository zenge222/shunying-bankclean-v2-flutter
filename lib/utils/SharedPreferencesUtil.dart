import 'dart:convert';

import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/utils/StringUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

///常用本地数据存储
class SharedPreferencesUtil {
  ///经度
  static void setLatitude(double latitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("latitude", latitude);
  }

  ///经度
  static Future<double> getLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double latitude = prefs.getDouble("latitude");
    return latitude == null ? 0 : latitude;
  }

  /// token
  static void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token == null ? "" : token;
  }

  /// 银行 银行id
  static void setBankId(int bankId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("bankId", bankId);
  }

  static Future<int> getBankId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int bankId = prefs.getInt("bankId");
    return bankId == null ? 0 : bankId;
  }

  /// 保洁 银行Name
  static void setCleanBankName(String bankName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("bankName", bankName);
  }

  static Future<String> getCleanBankName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bankName = prefs.getString("bankName");
    return bankName == null ? "" : bankName;
  }

  /// type  1 保洁 2 领班 3 主管 4 银行人员 5 区域经理 6 维修工
  static void setType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", type);
  }

  static Future<String> getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("type");
    return type == null ? "" : type;
  }

  /// 1银行(网点负责人)，2：保洁员（驻点）,3：保洁员（机动），4领班，5：主管，6：区域经理，7银行(区域负责人)，8银行(项目负责人),9维修工
  static void setResType(int type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("resType", type);
  }

  static Future<int> getResType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int type = prefs.getInt("resType");
    return type == null ? 0 : type;
  }


  /// 用户信息
  static void setUserInfo(UserVO userVO) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userVO", json.encode(userVO));
  }

  static Future<UserVO> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString("userVO");
    if (StringUtils.isEmpty(str)) {
      return null;
    } else {
      return UserVO.fromJson(json.decode(str));
    }
  }

  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
