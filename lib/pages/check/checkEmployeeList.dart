import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/cleanerVO.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/check/checkSchedulingEdit.dart';
import 'package:bank_clean_flutter/pages/check/employeeEntry.dart';
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

class CheckEmployeeList extends StatefulWidget {
  @override
  _CheckEmployeeListState createState() => _CheckEmployeeListState();
}

class _CheckEmployeeListState extends State<CheckEmployeeList>
    with ComPageWidget {
  FocusNode blankNode = FocusNode();
  int orgBranchId = 0;
  String orgBranchStr = '';
  String searchName = "";
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
          '员工名单',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("员工录入",
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(32),
                )),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeEntry(
                      id: 0,
                      isAdd: 0,
                    ),
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
        ],
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: GestureDetector(
          onTap: () {
            // 点击空白页面关闭键盘
            FocusScope.of(context).requestFocus(blankNode);
          },
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
                            resList = [];
                            isGetAll = false;
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
                  right: ScreenUtil().setWidth(32),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OutletsSelect(type: 1),
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
                                    Radius.circular(ScreenUtil().setWidth(26))),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text('${orgBranchStr}',
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
                  ],
                ),
              ),

              /// 列表
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(32),
                    ),
                    child: _buildList(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTime = new DateTime.now();
    setState(() {
      isLoading = true;
      isGetAll = true;
    });
    _getBranchList();
  }

  /// 通过网点列表 获取第一个网点
  Future _getBranchList() async {
    Map params = new Map();
    params['pageNo'] = 1;
    params['pageSize'] = 10;
    params['type'] = 2;
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

  Future _getDataList() async {
    Map params = new Map();
    params['orgBranchId'] = orgBranchId;
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['searchName'] = searchName;
    params['type'] = 4;
    Api.getCleanerList(map: params).then((res) {
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
                print('sel');
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
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
                    ClipRRect(
                      child: Image.network(
                        '${resList[index].baseUrl+resList[index].profile}',
                        width: ScreenUtil().setWidth(196),
                        height: ScreenUtil().setHeight(196),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${resList[index].name}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
//                              Container(
//                                margin: EdgeInsets.fromLTRB(
//                                    ScreenUtil().setWidth(0),
//                                    ScreenUtil().setHeight(16),
//                                    ScreenUtil().setWidth(0),
//                                    ScreenUtil().setHeight(16)),
//                                padding: EdgeInsets.fromLTRB(
//                                    ScreenUtil().setWidth(10),
//                                    ScreenUtil().setHeight(2),
//                                    ScreenUtil().setWidth(10),
//                                    ScreenUtil().setHeight(2)),
//                                decoration: BoxDecoration(
//                                  color: ColorUtil.color('#F2F2F2'),
//                                  borderRadius: BorderRadius.all(
//                                      Radius.circular(
//                                          ScreenUtil().setWidth(8))),
//                                ),
//                                child: Text('${resList[index].taskName}',
//                                    style: TextStyle(
//                                        color: ColorUtil.color('#666666'),
//                                        fontSize: ScreenUtil().setSp(28),
//                                        fontWeight: FontWeight.bold)),
//                              ),
//                              Text(
//                                  '${resList[index].workStartTime}-${resList[index].workEndTime}',
//                                  style: TextStyle(
//                                    color: ColorUtil.color('#666666'),
//                                    fontSize: ScreenUtil().setSp(24),
//                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(12)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setHeight(8)),
                                      width: ScreenUtil().setWidth(32),
                                      child: Image.asset(
                                          'lib/images/call_phone_icon.png'),
                                    ),
                                    Text('${resList[index].phone}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(24),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: ScreenUtil().setWidth(112),
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
                              child: Text('修改',
                                  style: TextStyle(
                                    color: ColorUtil.color('#CF241C'),
                                    fontSize: ScreenUtil().setSp(28),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeEntry(
                                        id: resList[index].id,
                                        isAdd: 1,
                                      ),
                                    )).then((data) {
                                  if (data == 'init') {
                                    print('刷新list');
                                  }
                                });
                              },
                            ),
                          ),
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
