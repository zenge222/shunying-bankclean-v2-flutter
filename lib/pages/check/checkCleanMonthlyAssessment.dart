import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/cleanerVO.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/check/checkAssessmentDetail.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';

class CheckCleanMonthlyAssessment extends StatefulWidget {
  @override
  _CheckCleanMonthlyAssessmentState createState() => _CheckCleanMonthlyAssessmentState();
}

class _CheckCleanMonthlyAssessmentState extends State<CheckCleanMonthlyAssessment>
    with ComPageWidget {
  int orgBranchId = 0;
  String orgBranchStr = '';
  String searchName = "";
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  List<UserVO> resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '保洁月考核',
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
        isLoading: false,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(30),
                  ScreenUtil().setHeight(16),
                  ScreenUtil().setWidth(30),
                  ScreenUtil().setHeight(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(10),
                          ScreenUtil().setWidth(30),
                          ScreenUtil().setHeight(0)),
//                    width: ScreenUtil().setWidth(530.0),
                      height: ScreenUtil().setHeight(70.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(5))),
                        color: ColorUtil.color('#ffffff'),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setHeight(0)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#F8F8FA'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(36))),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            searchName = text;
                          },
                          decoration: InputDecoration(
                            icon: Container(
                                padding: EdgeInsets.all(0),
                                child: Image.asset(
                                  'lib/images/clean/search_icon.png',
                                  width: ScreenUtil().setWidth(32),
                                )),
                            contentPadding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0)),
                            hintText: "输入保洁员姓名",
                            hintStyle: TextStyle(
                                color: ColorUtil.color('#999999'),
                                fontSize: ScreenUtil().setSp(28)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 0,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 0,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pageNum = 1;
                          isGetAll = false;
                          resList = [];
                        });
                        _getDataList();
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(96),
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(0),
                          bottom: ScreenUtil().setHeight(10),
                          right: ScreenUtil().setWidth(0),
                        ),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#CF241C'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(28))),
                        ),
                        child: Text(
                          '搜索',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /// sel
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(32),
                left: ScreenUtil().setWidth(32),
                bottom: ScreenUtil().setHeight(16),
                right: ScreenUtil().setWidth(32),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OutletsSelect(type: 5),
                                )).then((data) {
                              if (data != null) {
                                print('改变数据');
                                setState(() {
                                  orgBranchId = data.id;
                                  orgBranchStr = data.name;
                                  pageNum = 1;
                                  isGetAll = false;
                                  resList = [];
                                });
                                _getDataList();
                              }
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
                                  Radius.circular(
                                      ScreenUtil().setWidth(26))),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text('${orgBranchStr}',
                                    style: TextStyle(
                                      color:
                                      ColorUtil.color('#333333'),
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      ScreenUtil().setSp(28),
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
                  Container(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            ResetPicker.showDatePicker(context,
                                value: currentDate,
                                dateType: DateType.YM,
//                            minValue: DateTime(today.year - 1),
//                            maxValue: DateTime(today.year + 1,today.month,today.day),
                                title: '选择日期',
                                clickCallback: (timeStr, time) {
                                  setState(() {
                                    currentTime = timeStr;
                                    currentDate = DateTime.parse(time);
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
                                  Radius.circular(
                                      ScreenUtil().setWidth(26))),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text('${currentTime}',
                                    style: TextStyle(
                                      color:
                                      ColorUtil.color('#333333'),
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      ScreenUtil().setSp(28),
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
                ],
              ),
            ),

            /// 列表
            Expanded(child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(32),right: ScreenUtil().setWidth(32),),
              child: _buildList(),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    /// 首次进入请求数据
    DateTime dateTime = new DateTime.now();
    setState(() {
      isLoading = true;
      isGetAll = false;
      currentTime =
      '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}';
    });
    _getBranchList();
  }

  /// 通过网点列表 获取第一个网点
  Future _getBranchList() async {
    Map params = new Map();
    params['pageNo'] = 1;
    params['pageSize'] = 10;
    params['type'] = 5;
    params['searchWord'] = '';
    Api.getConfigOrgBranchList(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          orgBranchId = res.list[0].id;
          orgBranchStr = res.list[0].name;
        });
        _getDataList();
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getDataList()async{
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['orgBranchId'] = orgBranchId;
    params['dateStr'] = currentTime;
    params['searchName'] = searchName;
    Api.getCleanerAssessRecordList(map: params).then((res){
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckAssessmentDetail(id: resList[index].id,dateStr:currentTime),
                    )).then((data) {
                      setState(() {
                        isGetAll = false;
                        resList = [];
                        pageNum = 1;
                      });
                    _getDataList();
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child:Row(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network(
                        '${resList[index].baseUrl+resList[index].profile}',
                        width: ScreenUtil().setWidth(152),
                        height: ScreenUtil().setHeight(152),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20)),
                          padding: EdgeInsets.all(
                              ScreenUtil().setHeight(30)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${resList[index].name}',
                                      style: TextStyle(
                                        color: ColorUtil.color(
                                            '#333333'),
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: ScreenUtil()
                                            .setSp(32),
                                      )),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        ScreenUtil()
                                            .setWidth(0),
                                        ScreenUtil()
                                            .setHeight(16),
                                        ScreenUtil()
                                            .setWidth(0),
                                        ScreenUtil()
                                            .setHeight(16)),
                                    padding:
                                    EdgeInsets.fromLTRB(
                                        ScreenUtil()
                                            .setWidth(10),
                                        ScreenUtil()
                                            .setHeight(2),
                                        ScreenUtil()
                                            .setWidth(10),
                                        ScreenUtil()
                                            .setHeight(2)),
                                    decoration: BoxDecoration(
                                      color: ColorUtil.color(
                                          '#F2F2F2'),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil()
                                                  .setWidth(
                                                  8))),
                                    ),
                                    child: Text('${resList[index].organizationBranchName}',
                                        style: TextStyle(
                                            color:
                                            ColorUtil.color(
                                                '#666666'),
                                            fontSize:
                                            ScreenUtil()
                                                .setSp(28),
                                            fontWeight:
                                            FontWeight
                                                .bold)),
                                  ),
                                  Text('${resList[index].workStartTime}-${resList[index].workEndTime}',
                                      style: TextStyle(
                                        color: ColorUtil.color(
                                            '#666666'),
                                        fontSize: ScreenUtil()
                                            .setSp(28),
                                      )),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '${resList[index].aveScore==0?'--':resList[index].aveScore}',
                                        style: TextStyle(
                                            color: ColorUtil.color('#CF241C'),
                                            fontSize: ScreenUtil().setSp(40),
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '分',
                                        style: TextStyle(
                                          color: ColorUtil.color('#CF241C'),
                                          fontSize: ScreenUtil().setSp(24),
                                        )),
                                  ])),
                            ],
                          ),
                        ))
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
}
