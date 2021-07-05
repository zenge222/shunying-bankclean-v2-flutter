import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/leaveApply.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveApplyList extends StatefulWidget {
  @override
  _LeaveApplyListState createState() => _LeaveApplyListState();
}

class _LeaveApplyListState extends State<LeaveApplyList> with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<ItemVO> itemVOList = [];
  List dateList = [];
  int dateIndex = 0;
  int duringDate = 0; // 请求参数
  String currentDate = '';
  int status = 0;
  String statusStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '请假申请',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        // 默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: false,
        child: Column(
          children: <Widget>[
            /// sel
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
                      List<String> typeList = ['全部', '待审核', '已通过', '未通过'];
                      ResetPicker.showStringPicker(context,
                          data: typeList,
                          normalIndex: status,
                          title: "选择审批状态", clickCallBack: (int index, var str) {
                        setState(() {
                          statusStr = str;
                          status = index;
                          pageNum = 1;
                          isGetAll = false;
                          resList = [];
                        });
                        _getDataList();
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
                          Text('状态：${statusStr}',
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
                        _getDataList();
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
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(0),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(0)),
                child: _buildList(),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(80),
                  ScreenUtil().setHeight(16),
                  ScreenUtil().setWidth(80),
                  ScreenUtil().setHeight(16)),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(0),
                    ScreenUtil().setHeight(20),
                    ScreenUtil().setWidth(0),
                    ScreenUtil().setHeight(20)),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(60))),
                color: ColorUtil.color('#CF241C'),
                child: Text('请假申请',
                    style: TextStyle(
                      color: ColorUtil.color('#ffffff'),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                    )),
                onPressed: () {
//                  Application.router.navigateTo(context, Routers.leaveApply,
//                      transition: TransitionType.inFromRight);
                  /// 返回当前页刷新数据
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaveApply(),
                      )).then((data) {
                    if (data == 'init') {
                      setState(() {
                        pageNum = 1;
                        resList = [];
                        isGetAll = false;
                      });
                      _getDataList();
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
      statusStr = "全部";
      status = 0;
      pageNum = 1;
      isGetAll = false;
      resList = [];
    });
    _getDateList();
    _getDataList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getDataList();
      }
    });
  }

  Future _getDataList() async {
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['duringDate'] = duringDate;
    params['status'] = status;
    Api.getLeaveApplyList(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
        if (res.list.length < pageSize) {
          isGetAll = true;
        }
      }else{
        showToast(res.msg);
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
                Application.router.navigateTo(context,
                    Routers.leaveApplyDetail + '?id=${resList[index].id}',
                    transition: TransitionType.inFromRight);
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(40),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(40)),
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
                                  left: ScreenUtil().setWidth(22)),
                              decoration: BoxDecoration(
                                color: ColorUtil.color(
                                    resList[index].status == 1
                                        ? '#FFF4EC'
                                        : (resList[index].status == 2
                                            ? '#ECF1FF'
                                            : '#F2F2F2')),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Text(
                                  resList[index].status == 1
                                      ? '待审核'
                                      : (resList[index].status == 2
                                          ? '已通过'
                                          : '未通过'),
                                  style: TextStyle(
                                    color: ColorUtil.color(
                                        resList[index].status == 1
                                            ? '#CD8E5F'
                                            : (resList[index].status == 2
                                                ? '#375ECC'
                                                : '#666666')),
                                    fontSize: ScreenUtil().setSp(28),
                                  )),
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
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text('请假类型：${resList[index].typeText}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                      child: Text('申请人：${resList[index].cleanerName}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                      child: Text(
                          '请假时间：${resList[index].startDate + resList[index].startTimeText + ' - ' + resList[index].endDate + resList[index].endTimeText}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
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
          'lib/images/clean/no_clean_feedback_list.png',
          width: ScreenUtil().setWidth(560),
        ),
      );
    }
  }
}
