import 'dart:convert';
import 'dart:io';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/resDeviceItemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/bank/bankEvaluation.dart';
import 'package:bank_clean_flutter/pages/bank/bankHome.dart';
import 'package:bank_clean_flutter/pages/check/checkHome.dart';
import 'package:bank_clean_flutter/pages/check/checkScheduling.dart';
import 'package:bank_clean_flutter/pages/clean/cleanHome.dart';
import 'package:bank_clean_flutter/pages/common/me/Me.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectHome.dart';
import 'package:bank_clean_flutter/pages/regionalManager/regionHome.dart';
import 'package:bank_clean_flutter/pages/repairman/repairHome.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  // 1银行(网点负责人)，2：保洁员（驻点）,3：保洁员（机动），4领班，5：主管，6：区域经理，7银行(区域负责人)，8银行(项目负责人),9维修工
  final String type;

  const IndexPage({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> with ComPageWidget {
  List<Widget> tabBodies = [];
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomTabs = [];
  bool canClock = true;
  bool isLoading = false;
  String address = '';
  String dateStr = '';
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      //设置状态栏透明
//      statusBarColor: Colors.transparent,
//    ));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xFF666666),
        unselectedFontSize: ScreenUtil().setSp(20.0),
        selectedItemColor: Color(0xFFCF2519),
        selectedFontSize: ScreenUtil().setSp(20.0),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: widget.type == "1"
          ? FloatingActionButton(
              backgroundColor: Colors.transparent, //ColorUtil.color('#19be6b'),
              onPressed: () {
                if (canClock) {
                  setState(() {
                    isLoading = true;
                  });
                  _getLocation();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/images/clean/clock_in_icon.png',
                    width: ScreenUtil().setWidth(102),
                  ),
//                  Text('打卡'),
                ],
              ),
            )
          : widget.type == "6"
              ? FloatingActionButton(
                  backgroundColor:
                      Colors.transparent, //ColorUtil.color('#19be6b'),
                  onPressed: () async {
                    if (Platform.isIOS) {
                      PermissionStatus status = await PermissionHandler()
                          .checkPermissionStatus(PermissionGroup.camera);
                      if (status.value == 1) {
                        _scan();
                      } else {
                        //有可能是的第一次请求
                        _scan();
                      }
                    } else if (Platform.isAndroid) {
                      Map<PermissionGroup, PermissionStatus> permissions =
                          await PermissionHandler().requestPermissions([
                        PermissionGroup.camera
                      ]);
                      if (permissions[PermissionGroup.camera] !=
                          PermissionStatus.granted) {
                        showToast("请到设置中授予权限");
                      } else {
                        _scan();
                      }
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'lib/images/repairman/scan_code_icon.png',
                        width: ScreenUtil().setWidth(102),
                      ),
                    ],
                  ),
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: LoadingPage(
        isLoading: isLoading,
        child: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initBottomBar();
  }

  //扫码
  Future _scan() async {
    print('_scan_scan_scan_scan_scan');
    String cameraScanResult = await scanner.scan(); //通过扫码获取二维码中的数据
//    getScan(cameraScanResult); //将获取到的参数通过HTTP请求发送到服务器
    if(cameraScanResult!=null&&cameraScanResult!="") {
      Application.router.navigateTo(
          context, Routers.deviceInfo + '?id=${cameraScanResult}&btnType=1',
          transition: TransitionType.inFromRight);
    }
  }

  Future<bool> requestPermission() async {
    print('requestPermission');

    /// 只有当用户同时点选了拒绝开启权限和不再提醒后才会true
    bool isShown = await PermissionHandler()
        .shouldShowRequestPermissionRationale(PermissionGroup.location);
    print('isShown:' + isShown.toString());
    if (isShown == true) {
      showToast('需要定位权限');
      setState(() {
        canClock = true;
        isLoading = false;
      });
//      await PermissionHandler().openAppSettings();
      return false;
    } else {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions(
              [PermissionGroup.location, PermissionGroup.locationWhenInUse]);
      if (permissions[PermissionGroup.location] == PermissionStatus.granted &&
          permissions[PermissionGroup.locationWhenInUse] ==
              PermissionStatus.granted) {
//        setState(() {
//          canClock = true;
//        });
        return true;
      } else {
        setState(() {
          canClock = true;
          isLoading = false;
        });
        showToast('需要定位权限');
        return false;
      }
    }
  }

  _getLocation() async {
    setState(() {
      canClock = false;
    });
    if (await requestPermission()) {
      Location loc = await AmapLocation.fetchLocation();
      loc.address.then((val) {
        setState(() {
          address = val;
        });
        print('address:' + val);
      });
      loc.latLng.then((val) {
        setState(() {
          latitude = val.latitude;
          longitude = val.longitude;
        });
        print('longitude:' + val.longitude.toString());
        print('latitude:' + val.latitude.toString());
        _showClockInDialog(context);
//        SharedPreferencesUtil.setLongitude(val.longitude);
//        SharedPreferencesUtil.setLatitude(val.latitude);
      });
    }
  }

  Future _clockIn() async {
    Map params = new Map();
    params['address'] = address;
    params['latitude'] = latitude;
    params['longitude'] = longitude;
    Api.cleanerClockIn(map: params).then((res) {
      if (res.code == 1) {
        Application.router.pop(context);
      }
      showToast(res.msg);
    });
  }

  initBottomBar() {
    switch (widget.type) {

      /// 保洁
      case '1':
        tabBodies = [CleanHome(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset('lib/images/icon-home-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/icon-mine.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/icon-mine-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;

      /// 领班
      case '2':
        tabBodies = [CheckHome(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset(
                  'lib/images/check/home_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/check/my_icon.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/check/my_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;

      /// 项目主管/经理  区域经理
      case '3':
        tabBodies = [RegionHome(), CheckScheduling(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset(
                  'lib/images/check/home_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/check/scheduling_icon.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset(
                  'lib/images/check/scheduling_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("排班")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/check/my_icon.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/check/my_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;

      /// 银行人员
      case '4':
        tabBodies = [BankHome(), BankEvaluation(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset('lib/images/icon-home-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/bank/assessment_icon.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset(
                  'lib/images/bank/assessment_icon_active.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("考核")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/icon-mine.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/icon-mine-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;

      /// 区域经理 项目经理
      case '5':
        tabBodies = [ProjectHome(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset('lib/images/icon-home-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/icon-mine.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/icon-mine-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;
    /// 维修工
      case '6':
        tabBodies = [RepairHome(), MePage()];
        bottomTabs = [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset(
                'lib/images/icon-home.png',
                width: ScreenUtil().setWidth(48),
              ),
              activeIcon: new Image.asset('lib/images/icon-home-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("首页")),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: new Image.asset('lib/images/icon-mine.png',
                  width: ScreenUtil().setWidth(48)),
              activeIcon: new Image.asset('lib/images/icon-mine-selected.png',
                  width: ScreenUtil().setWidth(48)),
              title: Text("我的"))
        ];
        break;
      default:
        print('type:' + widget.type);
    }
  }

  void _showClockInDialog(BuildContext context) {
    DateTime today = DateTime.now();
    setState(() {
      String hour = today.hour < 10 ? '0${today.hour}' : today.hour.toString();
      String minute =
          today.minute < 10 ? '0${today.minute}' : today.minute.toString();
      dateStr = '${hour}:${minute}';
      canClock = true;
      isLoading = false;
    });
    showDialog(
        context: context,
        barrierDismissible: false, // 外部是否可消失
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency, //透明类型
              child: Stack(
                overflow: Overflow.visible, // 溢出显示
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(540),
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(90)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(14))),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(70),
                            ScreenUtil().setHeight(134),
                            ScreenUtil().setWidth(70),
                            ScreenUtil().setHeight(48)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // 内容自适应
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min, // 内容自适应
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(10)),
                                  child: Image.asset(
                                    'lib/images/clean/clock_in_icon2.png',
                                    width: ScreenUtil().setWidth(36),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(4)),
                                  child: Text('${address}',
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: ColorUtil.color('#000000'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(36),
                                      )),
                                ))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(20),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(60)),
                              child: Text('${dateStr}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#000000'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(72),
                                  )),
                            ),
                            MaterialButton(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(96),
                              color: ColorUtil.color('#CF241C'),
                              textColor: Colors.white,
                              child: Text('打卡',
                                  style: TextStyle(
                                    color: ColorUtil.color('#ffffff'),
                                    fontSize: ScreenUtil().setSp(36),
                                  )),
                              onPressed: () {
                                _clockIn();
                              },
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Application.router.pop(context);
                        },
                        child: Image.asset(
                          'lib/images/clean/close_icon.png',
                          width: ScreenUtil().setWidth(80),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: ScreenUtil().setHeight(-86),
                      child: Image.asset(
                        'lib/images/clean/clock_pic.png',
                        width: ScreenUtil().setWidth(172),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
