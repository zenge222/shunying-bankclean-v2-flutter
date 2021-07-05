import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class BankSchedulingDemandList extends StatefulWidget {
  @override
  _BankSchedulingDemandListState createState() =>
      _BankSchedulingDemandListState();
}

/// 银行

class _BankSchedulingDemandListState extends State<BankSchedulingDemandList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List<String> subTabs = ['待排班', '已排班', '已失效'];
  int subTabsIndex = 0;
  String type = '';

//  String surplusHours = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '排班需求',
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
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#ffffff'),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(8))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('${resList[index].title}',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold)),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(12)),
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(10),
                                    ScreenUtil().setHeight(2),
                                    ScreenUtil().setWidth(10),
                                    ScreenUtil().setHeight(2)),
                                decoration: BoxDecoration(
                                  color: ColorUtil.color(
                                      resList[index].status == 1
                                          ? '#FFE7E6'
                                          : (resList[index].status == 2
                                              ? '#ECF1FF'
                                              : '#f2f2f2')),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                ),
                                child: Text('${resList[index].statusText}',
                                    style: TextStyle(
                                        color: ColorUtil.color(
                                            resList[index].status == 1
                                                ? '#CF241C'
                                                : (resList[index].status == 2
                                                    ? '#375ECC'
                                                    : '#999999')),
                                        fontSize: ScreenUtil().setSp(28),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          Text('${resList[index].createTime}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              ))
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                        child:
                            Text('网点：${resList[index].organizationBranchName}',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: Text('排班日期：${resList[index].workDate}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: Text(
                            '排班时间：${resList[index].startTime}-${resList[index].endTime}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: Text('时长：${resList[index].duration}小时',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: ScreenUtil().setHeight(32),
                    right: ScreenUtil().setWidth(32),
                    child: Offstage(
                      offstage: resList[index].status!=1,
                      child: Container(
                        width: ScreenUtil().setWidth(160),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(12),
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(12)),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: ColorUtil.color('#CF241C'),
                                width: ScreenUtil().setWidth(1),
                              ),
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(60))),
                          color: ColorUtil.color('#ffffff'),
                          child: Text(type == "4" ? '删除申请' : '处理',
                              style: TextStyle(
                                color: ColorUtil.color('#CF241C'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(28),
                              )),
                          onPressed: () async {
                            if (type == "4") {
                              showCustomDialog(context, '确认取消申请', () {
                                Map params = new Map();
                                params['id'] = resList[index].id;
                                Api.taskRequestCancel(map: params).then((res) {
                                  if (res.code == 1) {
                                    setState(() {
                                      isLoading = true;
                                      isGetAll = false;
                                      pageNum = 1;
                                      resList = [];
                                    });
                                    Application.router.pop(context);
                                    _getMaterialApplyList();
                                  }
                                  showToast(res.msg);
                                });
                              });
                            } else {
                              Application.router.navigateTo(
                                  context, Routers.goToScheduling + '?id=123',
                                  transition: TransitionType.inFromRight);
                            }
                          },
                        ),
                      ),
                    ))
              ],
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
    setState(() {
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
    _getType();
//    _getMaterialTime();
    _getMaterialApplyList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaterialApplyList();
      }
    });
  }

//  Future _getMaterialTime() async {
//    Api.getMaterialTime().then((res) {
//      if (res.code == 1) {
//        setState(() {
//          surplusHours = res.value;
//        });
//      } else {
//        showToast(res.msg);
//      }
//    });
//  }
  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  Future _getMaterialApplyList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['status'] = subTabsIndex == 0 ? 1 : (subTabsIndex == 1 ? 2 : 3);
    Api.getTaskRequestList(map: params).then((res) {
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
