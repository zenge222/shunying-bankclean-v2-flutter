import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/cleanerVO.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';

class CleanSelect extends StatefulWidget {
  final int id;
  final int type;
  final int feedbackId;

  /*
    1:排班需求-列表-详情-人员选择(参数传pageNo,pageSize,searchName,orgBranchId)
    2:请假审批-代班人列表(参数传pageNo,pageSize,searchName)
    3:清扫反馈-人员选择(参数传pageNo,pageSize,searchName,feedbackId)
    4:员工名单-列表(参数传pageNo,pageSize,searchName,orgBranchId)
    5：排班-人员选择(参数传pageNo,pageSize,searchName,orgBranchId)
    6：巡检选择(参数传pageNo,pageSize,searchName,orgBranchId)
    7：项目经理+巡检，区域经理发布清扫需求(参数传pageNo,pageSize,searchName,orgBranchId)
  */
  const CleanSelect({Key key, this.id, this.type, this.feedbackId})
      : super(key: key);

  @override
  _CleanSelectState createState() => _CleanSelectState();
}

class _CleanSelectState extends State<CleanSelect> with ComPageWidget {
  String searchName = "";
  List resList = [];
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
          '保洁选择',
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
                            hintText: "请输入保洁姓名",
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
                          resList = [];
                          pageNum = 1;
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
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
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
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['orgBranchId'] = widget.id;
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['searchName'] = searchName;
    params['type'] = widget.type;
    if (widget.type == 3) {
      params['feedbackId'] = widget.feedbackId;
    }
    if (widget.type == 2) {
      params['workOffApplyId'] = widget.feedbackId;
    }
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
                resList.forEach((val) {
                  val.select = false;
                });
                setState(() {
                  resList[index].select = !resList[index].select;
                });
                UserVO cleanerVO = resList[index];
                Navigator.pop(context, cleanerVO);
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(36)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(168),
                          child: Text('${resList[index].name}',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(36),
                              )),
                        ),
                        Text('  ${resList[index].organizationBranchName}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            ))
                      ],
                    ),
                    Image.asset(
                      resList[index].select
                          ? 'lib/images/check/checked_icon.png'
                          : 'lib/images/check/check_icon.png',
                      width: ScreenUtil().setWidth(32),
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
