import 'dart:async';
import 'package:bank_clean_flutter/pages/bank/bankHome.dart';
import 'package:bank_clean_flutter/pages/check/checkHome.dart';
import 'package:bank_clean_flutter/pages/clean/cleanHome.dart';
import 'package:bank_clean_flutter/pages/common/login/Login.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectHome.dart';
import 'package:bank_clean_flutter/pages/regionalManager/regionHome.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  var indexPage;
  bool showIndex = false;
  int _countdownTime = 1;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    return

//      Stack(
//      children: <Widget>[
////        Offstage(
////          child: indexPage,
////          offstage: !showIndex,
////        ),
////        Offstage(
////          child: Center(
////            child: Text("启动页" + _countdownTime.toString() + "秒后爆炸"),
////          ),
////          offstage: showIndex,
////        )
//      ],
//    );
        Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorUtil.color('#CF241C'),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('lib/images/splash_bg.png'),
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: Text('')),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
            child: Text(
              '金洁士版权所有',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
    /// 延时任务
    Future.delayed(Duration(seconds: 1), () {
      SharedPreferencesUtil.getType().then((type) {
        if (type != null && type != '') {
          Application.router.navigateTo(
              context, Routers.indexPage + '?type=${type}',
              transition: TransitionType.inFromRight, clearStack: true);
        } else {
          Application.router.navigateTo(context, '/login',
              clearStack: true, transition: TransitionType.inFromRight);
        }
      });
    });
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownTime == 0) {
        setState(() {
          showIndex = true;
        });
        _timer.cancel();
        return;
      }
      _countdownTime--;
      setState(() {
        _countdownTime = _countdownTime;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
