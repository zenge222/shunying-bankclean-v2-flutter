import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/check/onlineInspectionAdd.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';

class OnlineInspectionList extends StatefulWidget {
  @override
  _OnlineInspectionListState createState() => _OnlineInspectionListState();
}

/// 巡检(可新增记录)+项目经理
class _OnlineInspectionListState extends State<OnlineInspectionList>
    with ComPageWidget {
  String searchName = "";
  List resList = [];
  bool isLoading = false;
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<String> selList = ['间隔最短', '最近巡检', '次数最多'];
  int selIndex = 0;
  String selStr = '间隔最短';
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点巡检',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        actions: <Widget>[
          type != '5'
              ? FlatButton(
                  child: Text("新增记录",
                      style: TextStyle(
                        color: ColorUtil.color('#333333'),
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnlineInspectionAdd(
                              outletsId: 0, outletsStr: "''"),
                        )).then((data) {
                      if (data == 'init') {
                        setState(() {
                          pageNum = 1;
                          isGetAll = false;
                          resList = [];
                        });
                        _getList();
                      }
                    });
                  },
                )
              : Text(''),
        ],
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
                            ResetPicker.showStringPicker(context,
                                data: selList,
                                normalIndex: selIndex,
                                title: "选择排序",
                                clickCallBack: (int index, var str) {
                              setState(() {
                                pageNum = 1;
                                isGetAll = false;
                                resList = [];
                                selStr = str;
                                selIndex = index;
                              });
                              _getList();
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
                                Text('${selStr}',
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
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      selIndex = 0;
      selStr = '间隔最短';
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
    _getType();
    _getList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getList();
      }
    });
  }

  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  Future _getList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['sortType'] = selIndex + 1;
    Api.getOrgCheckRecordList(map: params).then((res) {
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
                Application.router.navigateTo(context,
                    Routers.onlineInspectionRecord + '?id=${resList[index].id}',
                    transition: TransitionType.inFromRight);
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(26))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('${resList[index].organizationBranchName}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                            Offstage(
                              offstage: resList[index].timeout == 2,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(22)),
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(0),
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(0)),
                                decoration: BoxDecoration(
                                  color: ColorUtil.color('#CF241C'),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                ),
                                child: Text('巡检超时',
                                    style: TextStyle(
                                      color: ColorUtil.color('#ffffff'),
                                      fontSize: ScreenUtil().setSp(24),
                                    )),
                              ),
                            )
                          ],
                        ),
                        Text('时间间隔：${resList[index].interval}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(28),
                            ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                      child: Text('巡检员：${resList[index].areaManagerName}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                      child: Text('巡检记录：${resList[index].checkCount}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '最近巡检时间：${resList[index].nearDate == null ? '还未巡检' : resList[index].nearDate}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                          Text('记录查看>',
                              style: TextStyle(
                                color: ColorUtil.color('#CF241C'),
                                fontSize: ScreenUtil().setSp(28),
                              ))
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
}
