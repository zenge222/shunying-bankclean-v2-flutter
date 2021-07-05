import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkFeedbackDetail.dart';
import 'package:bank_clean_flutter/pages/check/checkleaveApplyDetail.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CheckFeedbackList extends StatefulWidget {
  @override
  _CheckFeedbackListState createState() => _CheckFeedbackListState();
}

/// 区域经理 + 银行人员
class _CheckFeedbackListState extends State<CheckFeedbackList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List<String> subTabs = ['待分配', '待处理', '已处理'];
  List<OrgBranchVO> branchList = [];
  int subTabsIndex = 0;
  String surplusHours = '';
  String dateStr = '';
  String outletsStr = '全部';
  int outletsIndex = 0;
  DateTime currentDate = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '清扫反馈',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        brightness: Brightness.light,
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// tabs
            Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorUtil.color('#F5F6F9'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(36),
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(36)),
                child: Row(
                  children: _tabItem(context),
                ),
              ),
            ),

            /// 选择
            Container(
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(24),
                  ScreenUtil().setHeight(36),
                  ScreenUtil().setWidth(24),
                  ScreenUtil().setHeight(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      /// 网点选择

                      var list = [];
                      branchList.forEach((val) {
                        list.add(val.name);
                      });
                      ResetPicker.showStringPicker(context,
                          data: list,
                          normalIndex: outletsIndex,
                          title: "选择网点", clickCallBack: (int index, var str) {
                        setState(() {
                          pageNum = 1;
                          resList = [];
                          outletsIndex = index;
                          outletsStr = str;
                          isGetAll = false;
                        });
                        _getMaterialApplyList();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(24),
                          ScreenUtil().setHeight(10),
                          ScreenUtil().setWidth(12),
                          ScreenUtil().setHeight(10)),
                      decoration: BoxDecoration(
                        color: ColorUtil.color('#ffffff'),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(26))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text('网点：${outletsStr}',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(28),
                              )),
                          Container(
                            margin:
                                EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                            child: Image.asset(
                              'lib/images/sel_picker.png',
                              width: ScreenUtil().setWidth(28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
//                  GestureDetector(
//                    onTap: () {
//                      ResetPicker.showDatePicker(context,
//                          value: currentDate,
//                          dateType: DateType.YMD,
////                            minValue: DateTime(today.year - 1),
//                            maxValue: DateTime.now(),
//                          title: '选择日期', clickCallback: (timeStr, time) {
//                        print(timeStr);
//                        setState(() {
//                          pageNum = 1;
//                          resList = [];
//                          isGetAll = false;
//                          dateStr = timeStr;
//                          currentDate = DateTime.parse(time);
//                        });
//                        _getMaterialApplyList();
//                      });
//                    },
//                    child: Container(
//                      padding: EdgeInsets.fromLTRB(
//                          ScreenUtil().setWidth(24),
//                          ScreenUtil().setHeight(10),
//                          ScreenUtil().setWidth(12),
//                          ScreenUtil().setHeight(10)),
//                      decoration: BoxDecoration(
//                        color: ColorUtil.color('#ffffff'),
//                        borderRadius: BorderRadius.all(
//                            Radius.circular(ScreenUtil().setWidth(26))),
//                      ),
//                      child: Row(
//                        children: <Widget>[
//                          Text('${dateStr == '' ? '选择日期' : dateStr}',
//                              style: TextStyle(
//                                color: ColorUtil.color('#333333'),
//                                fontWeight: FontWeight.bold,
//                                fontSize: ScreenUtil().setSp(28),
//                              )),
//                          Container(
//                            margin:
//                                EdgeInsets.only(left: ScreenUtil().setWidth(8)),
//                            child: Image.asset(
//                              'lib/images/sel_picker.png',
//                              width: ScreenUtil().setWidth(28),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
//              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(0),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(0)),
              child: _buildList(),
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> _tabItem(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < subTabs.length; i++) {
      widgets.add(Expanded(
          child: GestureDetector(
        onTap: () {
          _tabsCheck(i);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              0, ScreenUtil().setHeight(12), 0, ScreenUtil().setHeight(12)),
          decoration: BoxDecoration(
            color: subTabsIndex == i
                ? ColorUtil.color('#CF241C')
                : Colors.transparent,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
          ),
          child: Text(
            subTabs[i],
            style: TextStyle(
                color: subTabsIndex == i
                    ? ColorUtil.color('#ffffff')
                    : ColorUtil.color('#CF241C'),
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(32)),
            textAlign: TextAlign.center,
          ),
        ),
      )));
    }
    return widgets;
  }

  void _tabsCheck(int i) {
    setState(() {
      subTabsIndex = i;
      pageNum = 1;
      resList = [];
      isGetAll = false;
    });
    _getMaterialApplyList();
  }

  Widget _buildList() {
    if (resList.length != 0) {
      return ListView.builder(
        //+1 for progressbar
        itemCount: resList.length + 1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == resList.length) {
            return dataMoreLoading(isGetAll);
          } else {
            return GestureDetector(
              onTap: () {
                /// 返回当前页刷新数据
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckFeedbackDetail(id: resList[index].id),
                    )).then((data) {
                  if (data == 'init') {
                    setState(() {
                      pageNum = 1;
                      resList = [];
                      isGetAll = false;
                    });
                    _getMaterialApplyList();
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: Row(
                          children: <Widget>[
                            Text('${resList[index].title}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                            Offstage(
                              offstage: resList[index].areaLeaderTimeout!=1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10)),
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(0),
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(4)),
                                decoration: BoxDecoration(
                                  color: ColorUtil.color('#CF241C'),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                ),
                                child: Text('超时',
                                    style: TextStyle(
                                      color: ColorUtil.color('#ffffff'),
                                      fontSize: ScreenUtil().setSp(24),
                                    )),
                              ),
                            )
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(subTabsIndex == 0
                                ? '#FFE7E6'
                                : (subTabsIndex == 1 ? '#FFF4EC' : '#f2f2f2')),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text(
                              subTabsIndex == 0
                                  ? '待分配'
                                  : (subTabsIndex == 1 ? '待处理' : '已处理'),
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0
                                      ? '#CF241C'
                                      : (subTabsIndex == 1
                                          ? '#CD8E5F'
                                          : '#666666')),
                                  fontSize: ScreenUtil().setSp(28),
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'lib/images/clean/feedback_address.png',
                                width: ScreenUtil().setWidth(24),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(6)),
                                child: Text(
                                    '${resList[index].organizationBranchName}'),
                              )
                            ],
                          ),
                          Text('${resList[index].createTime}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      );
    } else {
      return Center(
        child: Image.asset(
          'lib/images/default_no_list.png',
          width: ScreenUtil().setWidth(560),
        ),
      );
    }
  }

  @override
  void initState() {
    /// 首次进入请求数据
    DateTime dateTime = new DateTime.now();
//    dateStr
    setState(() {
      isLoading = true;
      isGetAll = false;
      dateStr =
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}-${dateTime.day > 10 ? dateTime.day : ('0' + dateTime.day.toString())}';
      resList = [];
    });
    _getOrgBranchList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaterialApplyList();
      }
    });
  }

  Future _getOrgBranchList() async {
    Api.getOrgBranchList().then((res) {
      if (res.code == 1) {
        setState(() {
          branchList = res.list;
          outletsStr = res.list[0].name;
        });
        _getMaterialApplyList();
      }
    });
  }

  Future _getMaterialApplyList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['date'] = dateStr;
    params['orgBranchId'] = branchList[outletsIndex].id;
    params['status'] = subTabsIndex == 0 ? 1 : (subTabsIndex == 1 ? 2 : 3);
    print(subTabsIndex == 0 ? 1 : (subTabsIndex == 1 ? 2 : 3));
    Api.getFeedbackList(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
        if (res.list.length < pageSize) {
          isGetAll = true;
        }
      } else {
        showToast(res.msg);
      }
    });
  }
}
