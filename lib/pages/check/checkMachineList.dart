import 'dart:io';
import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkMachineDetail.dart';
import 'package:bank_clean_flutter/pages/check/checkMachineInspect.dart';
import 'package:bank_clean_flutter/pages/common/repair/repairDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

//import 'package:flutter_plugin_qrcode/flutter_plugin_qrcode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckMachineList extends StatefulWidget {
  @override
  _CheckMachineListState createState() => _CheckMachineListState();
}

/// 领班
class _CheckMachineListState extends State<CheckMachineList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List branchList = [];
  String outletsStr = '全部';
  int outletsId = 0;
  int outletsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '机器保养检查记录',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        actions: <Widget>[
          FlatButton(
            child: Text("保养检查",
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(32),
                )),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckMachineInspect(),
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
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            List selList = [];
                            selList.add("全部");
                            branchList.forEach((val) {
                              selList.add(val.name);
                            });
                            ResetPicker.showStringPicker(context,
                                data: selList,
                                normalIndex: outletsIndex,
                                title: "选择排序",
                                clickCallBack: (int index, var str) {
                              setState(() {
                                pageNum = 1;
                                isGetAll = false;
                                resList = [];
                                outletsStr = str;
                                outletsIndex = index;
                              });
                              if (str == "全部") {
                                outletsId = 0;
                              } else {
                                branchList.forEach((val) {
                                  if (val.name == str) {
                                    outletsId = val.id;
                                  }
                                });
                              }
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
                                Text('网点：${outletsStr}',
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

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
    _getBranchList();
    _getDataList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getDataList();
      }
    });
  }

  Future _getBranchList() async {
    Api.getEquipmentOrgBranchList().then((res) {
      if (res.code == 1) {
        setState(() {
          branchList.addAll(res.list);
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getDataList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['orgBranchId'] = outletsId;
    Api.getEquipmentMaintainRecordList(map: params).then((res) {
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
                    Routers.checkMachineDetail + '?id=${resList[index].id}',
                    transition: TransitionType.inFromRight);
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
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Text('${resList[index].title}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${resList[index].organizationBranchName}'),
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
}
