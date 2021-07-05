import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkEventDetail.dart';
import 'package:bank_clean_flutter/pages/clean/feedbackDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckEventReportList extends StatefulWidget {
  @override
  _CheckEventReportListState createState() => _CheckEventReportListState();
}
/// 银行？
class _CheckEventReportListState extends State<CheckEventReportList> with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
//  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<ItemVO> itemVOList = [];
  List dateList = [];
  int duringDate = 0; // 请求参数
  String currentDate = '';
  int dateIndex = 0;
  List<String> subTabs = ['待处理', '已处理'];
  int subTabsIndex = 0;
  String dateStr = '请选择时间';
  DateTime selDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.color('#F5F6F9'),
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
          title: Text(
            '事件上报列表',
            style: TextStyle(color: ColorUtil.color('#333333')),
          ),
          centerTitle: true,
          brightness: Brightness.light,
          // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
          elevation: 0,
          //默认是4， 设置成0 就是没有阴影了
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
                    children: _items(context),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(36),
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        ResetPicker.showStringPicker(context,
                            data: dateList,
                            normalIndex: dateIndex,
                            title: "选择时间", clickCallBack: (int index, var str) {
                              setState(() {
                                currentDate = str;
                                dateIndex = index;
                                duringDate = itemVOList[index].key;
                                pageNum = 1;
                                isGetAll = false;
                                resList = [];
                              });
                              _getMoreData();
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
                            Text('时间：${currentDate}',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(8)),
                              child: Image.asset(
                                'lib/images/sel_picker.png',
                                width: ScreenUtil().setWidth(28),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 列表
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(0),
                    ScreenUtil().setWidth(24),
                    ScreenUtil().setHeight(36)),
                child: _buildList(),
              ))
            ],
          ),
        ));
  }

  @override
  void initState() {
    /// 首次进入请求数据
    DateTime today = new DateTime.now();
    setState(() {
      isLoading = true;
      selDateTime = today;
      dateStr = today.year.toString() +
          '-' +
          today.month.toString() +
          '-' +
          '12'; // today.day.toString()
    });
    _getDateList();
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  Future _getMoreData() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['duringDate'] = duringDate;
    params['status'] = subTabsIndex == 0 ? 1 : 2;
    Api.getReportList(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
        if (res.list.length < pageSize) {
          isGetAll = true;
        }
      }
    });
  }

  Future _getDateList() async {
    List list = [];
    Api.getDateList().then((res) {
      if (res.code == 1) {
        res.list.forEach((val) {
          list.add(val.value);
        });
        setState(() {
          itemVOList = res.list;
          dateList = list;
          dateIndex = 0;
          currentDate = res.list[0].value;
          duringDate = res.list[0].key;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _items(BuildContext context) {
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
                          CheckEventDetail(id: resList[index].id),
                    )).then((data){
                    if(data=='init'){
                      setState(() {
                        pageNum = 1;
                        resList = [];
                        isGetAll = false;
                      });
                      _getMoreData();
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
                        Text('${resList[index].title}',
                            style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontSize: ScreenUtil().setSp(36),
                                fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(subTabsIndex == 0 ?'#FFE7E6':'#F2F2F2'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text('${resList[index].statusText}',
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0 ?'#CF241C':'#666666'),
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
                                child: Text('${resList[index].organizationBranchName}'),
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

  void _tabsCheck(int i) {
    setState(() {
      subTabsIndex = i;
      pageNum = 1;
      resList = [];
      isGetAll = false;
    });
    _getMoreData();
  }
}
