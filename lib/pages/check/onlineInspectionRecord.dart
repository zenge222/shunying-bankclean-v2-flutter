import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/orgCheckRecordItemVO.dart';
import 'package:bank_clean_flutter/models/orgCheckRecordVO.dart';
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

class OnlineInspectionRecord extends StatefulWidget {
  final int id;

  const OnlineInspectionRecord({Key key, this.id}) : super(key: key);

  @override
  _OnlineInspectionRecordState createState() => _OnlineInspectionRecordState();
}

class _OnlineInspectionRecordState extends State<OnlineInspectionRecord>
    with ComPageWidget {
  String searchName = "";
  String type = "";
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 20;
  OrgCheckRecordVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点巡检记录',
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
        child: resData != null
            ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0)),
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
                                Text('${resData.organizationBranchName}',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text('时间间隔：${resData.interval}',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(28),
                                ))
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                          child: Text('巡检员：${resData.areaManagerName}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                          child: Text('巡检记录：${resData.checkCount}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setWidth(8)),
                          child: Text(
                              '最近巡检时间：${resData.nearDate == null ? '还未巡检' : resData.nearDate}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        )
                      ],
                    ),
                  ),

                  /// 列表
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setWidth(24),
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#ffffff'),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                          ),
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(26),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(26)),
                          child: Text('巡检记录',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Expanded(
                          child: Container(
                            child: _buildList(),
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: type == "5",
                    child: Container(
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
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(60))),
                        color: ColorUtil.color('#CF241C'),
                        child: Text('新增巡检记录',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        onPressed: () {
//                        Application.router.navigateTo(
//                            context,
//                            Routers.onlineInspectionAdd +
//                                '?outletsId=${resData.id}&outletsStr=${resData.organizationBranchName}',
//                            transition: TransitionType.inFromRight);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnlineInspectionAdd(
                                    outletsId: resData.id,
                                    outletsStr: resData.organizationBranchName),
                              )).then((data) {
                            if (data == 'init') {
                              setState(() {
                                pageNum = 1;
                                isLoading = true;
                                isGetAll = false;
                                resList = [];
                              });
                              _getList();
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              )
            : Text(''),
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
    params['orgBranchId'] = widget.id;
    Api.getOrgCheckRecord(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resData = res.data;
          resList.addAll(res.data.recordList);
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
                    Routers.onlineInspectionDetail + '?id=${resList[index].id}',
                    transition: TransitionType.inFromRight);
              },
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  border: Border(
                      top: BorderSide(
                          width: ScreenUtil().setWidth(1),
                          color: ColorUtil.color('#e5e5e5'))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('${resList[index].createTime}',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                            Offstage(
//                              resList[index].showTimeout == 2 ||
//                                  resList[index].showTimeout
                              offstage: _showItem(resList[index].showTimeout,
                                  resList[index].timeout),
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
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                          child: Text('巡检员：${resList[index].areaManagerName}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                      ],
                    ),
                    Text('详情>',
                        style: TextStyle(
                          color: ColorUtil.color('#CF241C'),
                          fontSize: ScreenUtil().setSp(28),
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

  bool _showItem(showTimeout, timeout) {
    if (showTimeout){
      if (timeout == 1){
        return false;
      }else {
        return true;
      }
    }else {
      return true;
    }
  }
}
