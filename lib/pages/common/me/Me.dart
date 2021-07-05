import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MePageState();
  }
}

class _MePageState extends State<MePage> with ComPageWidget {
  String type = '0';
  bool isLoading = false;
  int resType = 0;
  UserVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.color('#F2F2F2'),
//        appBar: AppBar(
//          backgroundColor: ColorUtil.color('#CF2519'),
//          title: Text(
//            '我的',
//            style: TextStyle(color: Colors.white),
//          ),
//          centerTitle: true,
//          brightness: Brightness.dark,
//        ),
        body: LoadingPage(
          isLoading: isLoading,
          child: resData != null
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                ScreenUtil().setHeight(140),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setWidth(36)),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'lib/images/my/my_page_bg.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
//                            _showModalBottomSheet(context);
                                  },
                                  child: Container(
                                    child: new ClipOval(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.network(
                                        '${resData.baseUrl != null ? resData.baseUrl + resData.profile : ''}',
                                        fit: BoxFit.cover,
                                        width: ScreenUtil().setWidth(170),
                                        height: ScreenUtil().setWidth(170),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      ScreenUtil().setHeight(20),
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setWidth(10)),
                                  child: Text('${resData.name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(40))),
                                ),
                                Text('${resData.typeName}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(28))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(32),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setWidth(0)),
                          child: Column(
                            children: <Widget>[
                              Offstage(
                                offstage: type == '0',
                                child: _itemOption(),
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(40),
                                      bottom: ScreenUtil().setHeight(80)),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(30),
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(30)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '退出',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(30)),
                                    ),
                                  ),
                                ),
                                onTap: () async {
//                          Profile profile =
//                              await SharedPreferencesUtil.getProfile();
                                  SharedPreferencesUtil.clear();
//                          SharedPreferencesUtil.setProfile(profile);
//                          Application.router.navigateTo(
//                              context, '/login?phone=${profile.phone}',
//                              transition: TransitionType.inFromLeft,
//                              clearStack: true);
                                  showCustomDialog(context, '确定退出', () {
                                    SharedPreferencesUtil.clear();
                                    Application.router.navigateTo(
                                        context, '/login',
                                        transition: TransitionType.inFromLeft,
                                        clearStack: true);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                )
              : Text(''),
        ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _getUserInfo();
  }

  /// 我的信息接口
  Future _getUserInfo() async {
    int appType = await SharedPreferencesUtil.getResType();
    Api.getMyUserInfo().then((res) {
      if (res.code == 1) {
        setState(() {
          resType = appType;
          resData = res.data;
          isLoading = false;
        });
        print('resType:' + resType.toString());
        _getPageType();
      } else {
        showToast(res.msg);
      }
    });
  }

  _getPageType() async {
    String resType = await SharedPreferencesUtil.getType();
    setState(() {
      type = resType;
    });
  }

  Widget _itemOption() {
    Widget widget;
    switch (type) {

      /// 保洁
      case '1':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 工作安排
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/work_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '工作安排',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(context, Routers.workArrange,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 物料申请
              Offstage(
                offstage: resType == 3,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(38),
                        ScreenUtil().setHeight(30),
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(0)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          child: Image.asset('lib/images/my/materiel_icon.png',
                              width: ScreenUtil().setHeight(40)),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(30)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: ColorUtil.color('#E5E5E5')))),
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      '物料申请',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(30)),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(20)),
                                  child: Icon(
                                    Icons.navigate_next,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Application.router.navigateTo(
                        context, Routers.materielApplyList,
                        transition: TransitionType.inFromRight);
                  },
                ),
              ),

              /// 考勤记录
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/check_work_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '考勤记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.cleanWorkRecord,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 事件信息
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.eventList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/event_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '事件信息',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 请假申请
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.leaveApplyList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/leave_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '请假申请',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 报修记录
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.repairList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/repair_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '报修记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        break;

      /// 领班
      case '2':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 事件上报
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon1.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '事件上报',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkEventReportList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 清扫反馈
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon3.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '清扫反馈',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkFeedbackList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 保洁月考核
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon4.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '保洁月考核',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkCleanMonthlyAssessment,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 网点巡检记录
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon5.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '网点巡检记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.onlineInspectionList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 设备报修
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.repairList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/repair_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '报修记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 机器保养检查
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.checkMachineList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/maintenance_inspection.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '机器保养检查',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        break;

      /// 主管
      case '3':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 事件上报
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon1.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '事件上报',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkEventReportList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 物料核算
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon2.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '物料核算',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkComputationList + '?index=0',
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 清扫反馈
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon3.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '清扫反馈',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkFeedbackList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 保洁月考核
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon4.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '保洁月考核',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkCleanMonthlyAssessment,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 网点巡检记录
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon5.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '网点巡检记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.onlineInspectionList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 设备报修
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.repairList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/my/repair_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '报修记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 设备盘点
              GestureDetector(
                onTap: () {
                  Application.router.navigateTo(context, Routers.inventoryRecordList,
                      transition: TransitionType.inFromRight);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset('lib/images/projectManager/inventory_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '设备盘点',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 员工名单
//              GestureDetector(
//                child: Container(
//                  padding: EdgeInsets.fromLTRB(
//                      ScreenUtil().setWidth(38),
//                      ScreenUtil().setHeight(30),
//                      ScreenUtil().setWidth(0),
//                      ScreenUtil().setHeight(0)),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                  ),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        padding:
//                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
//                        child: Image.asset(
//                            'lib/images/check/check_my_icon6.png',
//                            width: ScreenUtil().setHeight(40)),
//                      ),
//                      Expanded(
//                        child: Container(
//                          padding: EdgeInsets.only(
//                              bottom: ScreenUtil().setHeight(30)),
//                          decoration: BoxDecoration(
//                              border: Border(
//                                  bottom: BorderSide(
//                                      width: 0.5,
//                                      color: ColorUtil.color('#E5E5E5')))),
//                          margin:
//                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                child: Container(
//                                  child: Text(
//                                    '员工名单',
//                                    style: TextStyle(
//                                        fontSize: ScreenUtil().setSp(30)),
//                                  ),
//                                ),
//                              ),
//                              Container(
//                                margin: EdgeInsets.only(
//                                    right: ScreenUtil().setWidth(20)),
//                                child: Icon(
//                                  Icons.navigate_next,
//                                  color: Colors.grey,
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                onTap: () {
//                  Application.router.navigateTo(
//                      context, Routers.checkEmployeeList,
//                      transition: TransitionType.inFromRight);
//                },
//              ),
            ],
          ),
        );
        break;

      /// 银行人员
      case '4':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 事件上报
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon1.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '事件上报',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkEventReportList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 排班申请记录
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/regionalManager/region_apply_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '排班申请记录',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.bankSchedulingDemandList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 清扫反馈
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/check/check_my_icon3.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '清扫反馈',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.checkFeedbackList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 意见反馈
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/regionalManager/region_opinion.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '意见反馈',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(context, Routers.bankFeedback,
                      transition: TransitionType.inFromRight);
                },
              ),
            ],
          ),
        );
        break;

      /// 区域经理
      case '5':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 客户意见
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/projectManager/customer_opinion_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '客户意见',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.projectCustomerOpinionList,
                      transition: TransitionType.inFromRight);
                },
              ),

              /// 网点分配
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/projectManager/scrap_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '设备报废',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.equipmentScrapList,
                      transition: TransitionType.inFromRight);
                },
              ),
            ],
          ),
        );
        break;
    /// 维修员
      case '6':
        widget = Container(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              /// 设备报废
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(38),
                      ScreenUtil().setHeight(30),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(0)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                        child: Image.asset(
                            'lib/images/repairman/scrap_icon.png',
                            width: ScreenUtil().setHeight(40)),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color: ColorUtil.color('#E5E5E5')))),
                          margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '设备报废',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Application.router.navigateTo(
                      context, Routers.equipmentScrapList,
                      transition: TransitionType.inFromRight);
                },
              ),
            ],
          ),
        );
        break;
    }
    return widget;
  }
}
