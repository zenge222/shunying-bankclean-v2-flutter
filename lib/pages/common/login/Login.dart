import 'dart:async';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/index.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with ComPageWidget {
  Timer _timer; // 计时
  bool codeClick = true;
  int _countdownTime = 0;

  bool get _isTimeCountingDown => _countdownTime != 60;
  bool isLoading = false;
  String phoneId;
  String phoneNumber = "";
  String password = "";
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: ColorUtil.color('#ffffff'),
        body: LoadingPage(
          isLoading: isLoading,
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(116),
                  ScreenUtil().setHeight(136),
                  ScreenUtil().setWidth(116),
                  ScreenUtil().setHeight(0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(224),
                    child: Image.asset('lib/images/login_logo.png'),
                  ),

                  /// 手机号码
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(30),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(30),
                        ScreenUtil().setHeight(0)),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorUtil.color('#EAEAEA'),
                          width: ScreenUtil().setWidth(1)),
                      color: ColorUtil.color('#F4F4F5'),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(8))),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        phoneNumber = text;
                      },
                      keyboardType: TextInputType.number, // 只能弹出数字键盘
                      inputFormatters: <TextInputFormatter>[
//                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11) //限制长度
                      ],
                      decoration: InputDecoration(
                        icon: Container(
                            padding: EdgeInsets.all(0),
                            child: Image.asset(
                              'lib/images/phone_icon.png',
                              width: ScreenUtil().setWidth(40),
                            )),
                        contentPadding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(0),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(0),
                            ScreenUtil().setHeight(0)),
                        hintText: "请输入手机号",
                        hintStyle: TextStyle(
                            color: ColorUtil.color('#999999'),
                            fontSize: ScreenUtil().setSp(28)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: ColorUtil.color('#F8F8FA'),
                          width: 1,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: ColorUtil.color('#F8F8FA'),
                          width: 2,
                        )),
                      ),
                    ),
                  ),

                  /// 验证码
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(30),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(12),
                        ScreenUtil().setHeight(0)),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorUtil.color('#EAEAEA'),
                          width: ScreenUtil().setWidth(1)),
                      color: ColorUtil.color('#F4F4F5'),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(8))),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number, // 只能弹出数字键盘
                          inputFormatters: <TextInputFormatter>[
//                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6) //限制长度
                          ],
                          onChanged: (text) {
                            password = text;
                          },
                          decoration: InputDecoration(
                            icon: Container(
                                padding: EdgeInsets.all(0),
                                child: Image.asset(
                                  'lib/images/code_icon.png',
                                  width: ScreenUtil().setWidth(40),
                                )),
                            contentPadding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0)),
                            hintText: "请输入验证码",
                            hintStyle: TextStyle(
                                color: ColorUtil.color('#999999'),
                                fontSize: ScreenUtil().setSp(28)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 1,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 2,
                            )),
                          ),
                        )),
                        Container(
                          width: ScreenUtil().setWidth(200),
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(0),
                            bottom: ScreenUtil().setHeight(10),
                            right: ScreenUtil().setWidth(0),
                          ),
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#ffffff'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(4))),
                          ),
                          child: GestureDetector(
                            onTap: () {
//                              print('codeClick:$codeClick');
//                              if (codeClick) {
                              _getCode();
//                              }
                            },
                            child: Text(
                              _countdownTime > 0
                                  ? ' ${_countdownTime}s'
                                  : '验证码',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  fontWeight: FontWeight.bold,
                                  color: ColorUtil.color(_countdownTime > 0
                                      ? '#999999'
                                      : '#CF241C')),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                    child: FlatButton(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(20)),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8))),
                      color: ColorUtil.color('#CF241C'),
                      child: Text('登录',
                          style: TextStyle(
                            color: ColorUtil.color('#ffffff'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(32),
                          )),
                      onPressed: () {
                        _loginSubmit(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
//      phoneNumber = "13918225443";
//      password = "222222";
    });
  }

  /// 大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  void _getCode() async {
    if (_countdownTime == 0) {
      if (phoneNumber == "") {
        return showToast("请输入手机号");
      }
      if (!isChinaPhoneLegal(phoneNumber)) {
        return showToast("请输入正确的手机号");
      }
      Map params = new Map();
      params['phone'] = phoneNumber;
//      int timestamp =
//          DateTime.now().millisecondsSinceEpoch;
      setState(() {
        isLoading = true;
      });
      Api.getPhoneCode(map: params).then((res) {
        print('res.code:' + res.code.toString());

        if (res.code == 1) {
          setState(() {
            _countdownTime = 60;
            isLoading = false;
          });
          //开始倒计时
          startCountdownTimer();
        } else {
          setState(() {
            isLoading = false;
          });
          showToast(res.msg);
        }
      });
    }
  }

  ///倒计时
  void startCountdownTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  void _loginSubmit(BuildContext context) {
    if (phoneNumber == "") {
      return showToast("请输入手机号");
    }
    if (!isChinaPhoneLegal(phoneNumber)) {
      return showToast("请输入正确的手机号");
    }
    if (password == "") {
      return showToast("请输入验证码");
    }
    Map params = new Map();
    setState(() {
      isLoading = true;
    });
    params['captcha'] = password;
    params['phone'] = phoneNumber;
    print(phoneNumber + ':' + password);
    print('login---------------------------------');
    Api.sendCodeLogin(map: params).then((res) {
      int type = 0;
      if (res.code == 1) {
        UserVO userVO = UserVO.fromJson(res.dataMap);
        SharedPreferencesUtil.setToken(userVO.token);
        int resType = userVO.type;
        setState(() {
          isLoading = false;
        });
        if (resType == 2 || resType == 3) {
          // 保洁
          type = 1;
        } else if (resType == 4) {
          // 领班
          type = 2;
        } else if (resType == 5) {
          // 主管
          type = 3;
        } else if (resType == 1 || resType == 7 || resType == 8) {
          // 银行人员
          type = 4;
        } else if (resType == 6) {
          // 区域经理
          type = 5;
        } else if (resType == 9) {
          // 维修工
          type = 6;
        }
        SharedPreferencesUtil.setUserInfo(userVO);
        SharedPreferencesUtil.setType(type.toString());
        SharedPreferencesUtil.setResType(resType);
        Application.router.navigateTo(context, '/index?type=${type}',
            transition: TransitionType.inFromRight, clearStack: true);
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(res.msg);
      }
    });
  }
}
