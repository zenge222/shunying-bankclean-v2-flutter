import 'dart:io';
import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/repair/repairDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class RepairList extends StatefulWidget {
  @override
  _RepairListState createState() => _RepairListState();
}

/// 保洁 领班
class _RepairListState extends State<RepairList> with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List subTabs = ['待处理', '待维修', '已维修'];
  List branchList = [];
  String outletsStr = '全部';
  int outletsId = 0;
  int branchIndex = 0;
  int subTabsIndex = 0;
  String type = '';
  int outletsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          type == "1" ? '报修记录' : "设备报修列表",
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        actions: <Widget>[
          FlatButton(
            child: Text("扫码",
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(32),
                )),
            onPressed: () async {
              if (Platform.isIOS) {
                PermissionStatus status = await PermissionHandler()
                    .checkPermissionStatus(PermissionGroup.camera);
                if (status.value == 1) {
                  _scan();
                } else {
                  //有可能是的第一次请求
                  _scan();
                }
              } else if (Platform.isAndroid) {
                Map<PermissionGroup, PermissionStatus> permissions =
                    await PermissionHandler().requestPermissions(
                        [PermissionGroup.camera]);
                if (permissions[PermissionGroup.camera] !=
                    PermissionStatus.granted) {
                  showToast("请到设置中授予权限");
                } else {
                  _scan();
                }
              }
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
                  children: _tabItem(context),
                ),
              ),
            ),

            /// sel
            Offstage(
              offstage: type=="1",
              child: Container(
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
                              branchList.forEach((val) {
                                selList.add(val.name);
                              });
                              ResetPicker.showStringPicker(context,
                                  data: selList,
                                  normalIndex: branchIndex,
                                  title: "选择排序",
                                  clickCallBack: (int index, var str) {
                                    setState(() {
                                      pageNum = 1;
                                      isGetAll = false;
                                      resList = [];
                                      outletsStr = str;
                                      branchIndex = index;
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
                                  Text('设备位置：${outletsStr}',
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
    _getType();
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

  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  //扫码
  Future _scan() async {
    String cameraScanResult = await scanner.scan(); //通过扫码获取二维码中的数据
    print(cameraScanResult); // 返回 id
    if (cameraScanResult != null && cameraScanResult != "") {
      Application.router.navigateTo(
          context, Routers.deviceInfo + '?id=${cameraScanResult}&btnType=1',
          transition: TransitionType.inFromRight);
    }
  }

  List<Widget> _tabItem(BuildContext context) {
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

  void _tabsCheck(int i) {
    setState(() {
      subTabsIndex = i;
      pageNum = 1;
      resList = [];
      isGetAll = false;
    });
    _getDataList();
  }

  Future _getDataList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['orgBranchId'] = outletsId;
    params['status'] = subTabsIndex == 0 ? 1 : (subTabsIndex == 1 ? 2 : 3);
    Api.getEquipmentReportList(map: params).then((res) {
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
                /// 返回当前页刷新数据
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepairDetail(id: resList[index].id),
                    )).then((data) {
                  setState(() {
                    pageNum = 1;
                    resList = [];
                    isGetAll = false;
                  });
                  _getDataList();
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
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Text('${resList[index].equipmentName}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(subTabsIndex == 0
                                ? '#FFE7E6'
                                : (subTabsIndex == 1 ? '#ECF1FF' : '#f2f2f2')),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text("${resList[index].statusText}",
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0
                                      ? '#CF241C'
                                      : (subTabsIndex == 1
                                          ? '#375ECC'
                                          : '#666666')),
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
                          Text(
                              '${resList[index].projectName}-${resList[index].organizationBranchName}'),
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
