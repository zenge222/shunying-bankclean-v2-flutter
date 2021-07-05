import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/projectHomeVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/bank/bankOutletsSelect.dart';
import 'package:bank_clean_flutter/pages/check/checkComputationList.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectOutletsDistribute.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectHome extends StatefulWidget {
  @override
  _ProjectHomeState createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> with ComPageWidget {
  bool isLoading = false;
  ProjectHomeVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      body:
//        RefreshIndicator(
//          onRefresh: _refresh,
//        child:
          LoadingPage(
        isLoading: isLoading,
//          text: "正在加载数据",
        child: resData != null
            ? Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(280),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "lib/images/projectManager/project_home_bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// 头部
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(68),
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'lib/images/projectManager/project_home_logo.png',
                                width: ScreenUtil().setWidth(56),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(12)),
                                child: Text(
                                  '金洁士区域经理',
                                  style: TextStyle(
                                      color: ColorUtil.color('#ffffff'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 卡片头部
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(48),
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(0)),
                          child: Row(
                            children: <Widget>[
                              /// 网点分配
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProjectOutletsDistribute(),
                                        )).then((data) {
                                      if (data == 'init') {
                                        print('刷新list');
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(15)),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(32),
                                        ScreenUtil().setHeight(40),
                                        ScreenUtil().setWidth(0),
                                        ScreenUtil().setHeight(40)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setWidth(8))),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(6.0, 6.0),
                                          color: Color.fromARGB(16, 0, 0, 0),
                                          //阴影默认颜色,不能与父容器同时设置color
                                          blurRadius: ScreenUtil()
                                              .setHeight(12.0), //延伸距离,会有模糊效果
                                        )
                                      ],
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'lib/images/projectManager/project_home_card_bg1.png'),
                                        alignment: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '网点分配',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Offstage(
                                          offstage: false,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil()
                                                    .setHeight(120)),
                                            padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(2),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(2)),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.color(resData.orgBranchUnAllocationCount==0?'#ffffff':'#CF241C'),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ScreenUtil()
                                                      .setWidth(30))),
                                            ),
                                            child: Text(
                                              '${resData.orgBranchUnAllocationCount}',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#ffffff'),
                                                  fontSize:
                                                      ScreenUtil().setSp(36),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// 物料核算
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckComputationList(index: 0),
                                        )).then((data) {
                                      _getData();
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(15)),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(32),
                                        ScreenUtil().setHeight(40),
                                        ScreenUtil().setWidth(0),
                                        ScreenUtil().setHeight(40)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setWidth(8))),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(6.0, 6.0),
                                          color: Color.fromARGB(16, 0, 0, 0),
                                          //阴影默认颜色,不能与父容器同时设置color
                                          blurRadius: ScreenUtil()
                                              .setHeight(12.0), //延伸距离,会有模糊效果
                                        )
                                      ],
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'lib/images/projectManager/project_home_card_bg2.png'),
                                        alignment: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '物料核算',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(36),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Offstage(
                                          offstage: false,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil()
                                                    .setHeight(120)),
                                            padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(2),
                                                ScreenUtil().setWidth(10),
                                                ScreenUtil().setHeight(2)),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.color(resData.toolsUnCheckCount==0?'#ffffff':'#CF241C'),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ScreenUtil()
                                                      .setWidth(30))),
                                            ),
                                            child: Text(
                                              '${resData.toolsUnCheckCount}',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#ffffff'),
                                                  fontSize:
                                                      ScreenUtil().setSp(36),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 内容
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40)),
                            child: Column(children: [
                              /// 网点管理
                              GestureDetector(
                                onTap: () {
                                  Application.router.navigateTo(
                                      context, Routers.projectOutletsManageList,
                                      transition: TransitionType.inFromRight);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(24),
                                      ScreenUtil().setHeight(24),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(24)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/projectManager/home_card1.png',
                                            width: ScreenUtil().setWidth(142),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setHeight(32)),
                                            child: Text('网点管理',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(32),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(36),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(24)),
                                        child: Image.asset(
                                            'lib/images/projectManager/project_sel_right.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              /// 物料管理
                              Offstage(
                                offstage: true,
                                child: GestureDetector(
                                  onTap: () {
                                    Application.router.navigateTo(context,
                                        Routers.projectMaterielManageList,
                                        transition: TransitionType.inFromRight);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(32)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setWidth(8))),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(24),
                                        ScreenUtil().setHeight(24),
                                        ScreenUtil().setWidth(32),
                                        ScreenUtil().setHeight(24)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              'lib/images/projectManager/home_card1.png',
                                              width: ScreenUtil().setWidth(142),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setHeight(32)),
                                              child: Text('物料管理',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(32),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(36),
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(24)),
                                          child: Image.asset(
                                              'lib/images/projectManager/project_sel_right.png'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// 人员考核
                              GestureDetector(
                                onTap: () {
                                  Application.router.navigateTo(context,
                                      Routers.projectPersonnelAssessmentList,
                                      transition: TransitionType.inFromRight);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(32)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(24),
                                      ScreenUtil().setHeight(24),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(24)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/projectManager/home_card2.png',
                                            width: ScreenUtil().setWidth(142),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setHeight(32)),
                                            child: Text('人员考核',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(32),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(36),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(24)),
                                        child: Image.asset(
                                            'lib/images/projectManager/project_sel_right.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              /// 巡检记录
                              GestureDetector(
                                onTap: () {
                                  Application.router.navigateTo(
                                      context, Routers.onlineInspectionList,
                                      transition: TransitionType.inFromRight);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(32)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(24),
                                      ScreenUtil().setHeight(24),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(24)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/projectManager/home_card3.png',
                                            width: ScreenUtil().setWidth(142),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setHeight(32)),
                                            child: Text('巡检记录',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(32),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(36),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(24)),
                                        child: Image.asset(
                                            'lib/images/projectManager/project_sel_right.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              )
            : Text(''),
      ),
//        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future _getData() async {
    Api.getProjectHomeData().then((res) {
      if (res.code == 1) {
        setState(() {
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }
}
