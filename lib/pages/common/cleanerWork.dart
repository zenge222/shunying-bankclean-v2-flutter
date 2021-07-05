import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/models/taskItemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/floorSelect.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanerWork extends StatefulWidget {
  @override
  _CleanerWorkState createState() => _CleanerWorkState();
}

class _CleanerWorkState extends State<CleanerWork> with ComPageWidget {
  List taskVOList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  int floorIndex = 0;
  int orgBranchId = 0;
  int taskId = 0;
  String orgBranchStr = "全部";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '保洁工作',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: ScreenUtil().setHeight(1),
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
//          text: "正在加载数据",
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// sel
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(0),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(0)),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(0),
                    bottom: ScreenUtil().setHeight(0)),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(20)),
                      width: double.infinity,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OutletsSelect(type: 5),
                                    )).then((data) {
                                  if (data != null) {
                                    setState(() {
                                      orgBranchId = data.id;
                                      orgBranchStr = data.name;
                                      taskId = 0;
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
                                  color: ColorUtil.color('#EDEEF2'),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(26))),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text('网点：${orgBranchStr}',
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
                    ),
                   Offstage(
                     offstage: taskVOList.length == 0,
                     child:  Container(
                       padding: EdgeInsets.fromLTRB(
                           ScreenUtil().setWidth(0),
                           ScreenUtil().setHeight(20),
                           ScreenUtil().setWidth(0),
                           ScreenUtil().setHeight(20)),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Expanded(
                               child: Container(
                                 height: ScreenUtil().setHeight(60),
                                 child: ListView(
                                   scrollDirection: Axis.horizontal,
                                   children: _floorTabs(),
                                 ),
                               )),
                           GestureDetector(
                             onTap: () {
                               print('taskId:' + taskId.toString());
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => FloorSelect(
                                         id: taskId, orgId: orgBranchId),
                                   )).then((data) {
                                 if (data != null) {
                                   print('data:' + data.toString());
                                   setState(() {
                                     taskId = data;
                                   });
                                   _getDataList();
                                 }
                               });
                             },
                             child: Container(
                               width: ScreenUtil().setWidth(48),
                               child: Image.asset('lib/images/floor_tabs.png'),
                             ),
                           ),
                         ],
                       ),
                     ),
                   )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(24),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(0)),
                children: _workBuild(context),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDataList();
  }

  Future _getDataList() async {
    Map params = new Map();
    params['orgId'] = orgBranchId == 0 ? "" : orgBranchId;
    params['taskId'] = taskId == 0 ? '' : taskId;
    Api.taskIndexTaskInfo(map: params).then((res) {
      taskVOList = [];
      if (res.code == 1) {
//        if (res.data.taskVOList.length > 0) {
          setState(() {
            taskVOList = res.data.taskVOList;
          });
          if (taskId == 0) {
            setState(() {
              taskId = taskVOList[0].id;
            });
          }
          print('taskId:'+taskId.toString());
//        }
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _floorTabs() {
    List<Widget> list = [];
    if (taskVOList.length > 0) {
      for (int i = 0; i < taskVOList.length; i++) {
        list.add(GestureDetector(
          onTap: () {
            taskVOList.forEach((val) {
              val.select = false;
            });
            setState(() {
              taskVOList[i].select = true;
              taskId = taskVOList[i].id;
            });
            _getDataList();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(14),
                ScreenUtil().setHeight(8),
                ScreenUtil().setWidth(14),
                ScreenUtil().setHeight(0)),
            decoration: BoxDecoration(
              color: ColorUtil.color(
                  taskVOList[i].id == taskId ? '#CF241C' : '#ffffff'),
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
            ),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
            child: Text('${taskVOList[i].title}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    color: ColorUtil.color(
                        taskVOList[i].id == taskId ? '#ffffff' : '#555555'),
                    fontWeight: FontWeight.bold)),
          ),
        ));
      }
    }
    return list;
  }

  List<Widget> _workBuild(BuildContext context) {
    List<Widget> list = [];
//    List<TaskItemVO> resList = resData.taskItemVOList;
    if (taskVOList.length > 0) {
      List<TaskItemVO> resList = taskVOList[0].taskItemVOList;
      if (resList.length > 0) {
        for (int i = 0; i < resList.length; i++) {
          list.add(Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
            ),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(20),
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: ScreenUtil().setWidth(444),
                            ),
                            child: Text('${resList[i].title}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36),
                                  color: ColorUtil.color('#333333'),
                                )),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setHeight(2),
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setHeight(2)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color(
                              resList[i].status == 1 ? '#FFE7E6' : '#f2f2f2'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Text('${resList[i].statusText}',
                            style: TextStyle(
                                color: ColorUtil.color(resList[i].status == 1
                                    ? '#CF241C'
                                    : '#666666'),
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(20),
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${resList[i].cleanerName}',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(28),
                                color: ColorUtil.color('#333333'),
                              )),
                          Text('${resList[i].startTime}-${resList[i].endTime}',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(28),
                                color: ColorUtil.color('#333333'),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        }
      }
    }
    return list;
  }
}
