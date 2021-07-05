import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/assetInventory.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryRecordList extends StatefulWidget {
  @override
  _InventoryRecordListState createState() => _InventoryRecordListState();
}

class _InventoryRecordListState extends State<InventoryRecordList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false;
  bool isGetAll = false;
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List outletsList = [];
  String outletsStr = '';
  int outletsIndex = 0;
  List statusList = [];
  String statusStr = '全部';
  int statusIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          "资产盘点记录",
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        actions: <Widget>[
          FlatButton(
            child: Text("资产盘点",
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(32),
                )),
            onPressed: () {
              //
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AssetInventory(),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            List selList = [];
                            outletsList.forEach((val) {
                              selList.add(val.name);
                            });
                            ResetPicker.showStringPicker(context,
                                data: selList,
                                normalIndex: outletsIndex,
                                title: "选择网点",
                                clickCallBack: (int index, var str) {
                              setState(() {
                                pageNum = 1;
                                isGetAll = false;
                                resList = [];
                                outletsStr = str;
                                outletsIndex = index;
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            List selList = ["全部", "正常", "异常"];
                            ResetPicker.showStringPicker(context,
                                data: selList,
                                normalIndex: statusIndex,
                                title: "选择状态",
                                clickCallBack: (int index, var str) {
                              setState(() {
                                pageNum = 1;
                                isGetAll = false;
                                resList = [];
                                statusStr = str;
                                statusIndex = index;
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
          outletsList.addAll(res.list);
          outletsStr = res.list[0].name;
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
    params['orgBranchId'] =
        outletsList.length > 0 ? outletsList[outletsIndex].id : 0;
    params['status'] = statusIndex;
    Api.getPropertyCheckRecordList(map: params).then((res) {
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
                    Routers.inventoryDetail + '?id=${resList[index].id}',
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
                      children: <Widget>[
                        Text('资产盘点',
                            style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontSize: ScreenUtil().setSp(36),
                                fontWeight: FontWeight.bold)),
                        Offstage(
                          offstage: resList[index].status != 2,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(6),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(6),
                                ScreenUtil().setHeight(0)),
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(14)),
                            decoration: BoxDecoration(
                              color: ColorUtil.color('#CF241C'),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(4))),
                            ),
                            child: Text('异常',
                                style: TextStyle(
                                  color: ColorUtil.color('#ffffff'),
                                  fontSize: ScreenUtil().setSp(24),
                                )),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Text('${resList[index].organizationBranchName}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#666666'),
                                    fontSize: ScreenUtil().setSp(28),
                                  )),
                            ],
                          )),
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
