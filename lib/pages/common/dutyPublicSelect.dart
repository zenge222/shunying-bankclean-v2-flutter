import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/taskVO.dart';
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

class DutyPublicSelect extends StatefulWidget {
  final int id;

  const DutyPublicSelect({Key key, this.id}) : super(key: key);

  @override
  _DutyPublicSelectState createState() => _DutyPublicSelectState();
}
/// 公共职责选择列表 巡检+区域经理
class _DutyPublicSelectState extends State<DutyPublicSelect>
    with ComPageWidget {
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
          '职责选择',
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
                            hintText: "请输入职责名称",
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
    Api.getCheckTaskVOList(map: params).then((res) {
      if (res.code == 1) {
        TaskVO taskVO = new TaskVO();
        taskVO.id = -1;
        taskVO.title = '自定义';
        taskVO.startTime = '0';
        taskVO.endTime = '0';
        taskVO.cleanerName = '0';
        taskVO.cleanerPhone = '0';
        taskVO.cleanerPhone = '0';
        taskVO.select = false;
        resList.add(taskVO);
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
                TaskVO taskVO = resList[index];
                Navigator.pop(context, taskVO);
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
                          width: ScreenUtil().setWidth(500),
                          child: Text('${resList[index].title}',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(36),
                              )),
                        ),
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
