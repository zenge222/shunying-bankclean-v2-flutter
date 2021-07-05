import 'dart:convert';
import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AssetInventory extends StatefulWidget {
  @override
  _AssetInventoryState createState() => _AssetInventoryState();
}

class _AssetInventoryState extends State<AssetInventory> with ComPageWidget {
  bool isLoading = false;
  FocusNode blankNode = FocusNode();
  String content = '';
  int orgBranchId = 0;
  String orgBranchStr = "";
  List resList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '资产盘点',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        brightness: Brightness.light,
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: LoadingPage(
          isLoading: isLoading,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /// 1
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(8))),
                      ),
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OutletsSelect(type: 99), // 机械网点选择
                                )).then((data) {
                              if (data != null) {
                                setState(() {
                                  orgBranchId = data.id;
                                  orgBranchStr = data.name;
                                  isLoading = true;
                                });
                                _getDetail();
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Text('网点',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold))),
                              Row(
                                children: <Widget>[
                                  Text(
                                      '${orgBranchStr == "" ? "请选择" : orgBranchStr}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                  Container(
                                    width: ScreenUtil().setWidth(32),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(24)),
                                    child: Image.asset(
                                        'lib/images/clean/sel_right.png'),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),

                    /// 设备
                    Offstage(
                      offstage: orgBranchId == 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(24)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(30),
                                  ScreenUtil().setHeight(28),
                                  ScreenUtil().setWidth(30),
                                  ScreenUtil().setHeight(28)),
                              child: Text('设备',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(32),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Column(
                              children: _buildItem(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Offstage(
                offstage: orgBranchId == 0 || resList.length == 0,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(16),
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(16)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(13)),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(20),
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(20)),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: ColorUtil.color('#CF241C'),
                                width: ScreenUtil().setWidth(2),
                              ),
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(60))),
                          color: ColorUtil.color('#ffffff'),
                          child: Text('提交',
                              style: TextStyle(
                                color: ColorUtil.color('#CF241C'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(32),
                              )),
                          onPressed: () {
                            int count = 0;
                            resList.forEach((val) {
                              if (val.status != 1) {
                                count++;
                              }
                            });
                            showCustomDialog(context,
                                count == 0 ? "确定提交" : "有${count}件设备尚未盘点，是否提交",
                                () {
                              Application.router.pop(context);
                              _submitReport();
                            });
                          },
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(13)),
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
                          child: Text('扫码盘点',
                              style: TextStyle(
                                color: ColorUtil.color('#ffffff'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(32),
                              )),
                          onPressed: () async {
                            if (Platform.isIOS) {
                              PermissionStatus status =
                                  await PermissionHandler()
                                      .checkPermissionStatus(
                                          PermissionGroup.camera);
                              if (status.value == 1) {
                                _scan();
                              } else {
                                //有可能是的第一次请求
                                _scan();
                              }
                            } else if (Platform.isAndroid) {
                              Map<PermissionGroup, PermissionStatus>
                                  permissions = await PermissionHandler()
                                      .requestPermissions(
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
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future _getDetail() async {
    Map params = new Map();
    params['orgBranchId'] = orgBranchId;
    Api.getPropertyCheckRecordInfoList(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resList = res.list;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  //扫码
  Future _scan() async {
    String cameraScanResult = await scanner.scan(); //通过扫码获取二维码中的数据
    print('_scan id:' + cameraScanResult); // 返回 id
    if (cameraScanResult != null && cameraScanResult != "") {
      _getItem(int.parse(cameraScanResult));
    }else{
      showToast('请扫描正确的设备二维码');
    }
  }

  Future _getItem(int id) async {
    Map params = new Map();
    params["id"] = id;
    Api.getEquipmentDetail(map: params).then((res) {

      if (res.code == 1) {
        print(res.data.organizationBranchId == orgBranchId);
        print(res.data.organizationBranchId);
        print(orgBranchId);
        if (res.data.organizationBranchId != orgBranchId) {
          showCustomDialog(context, "该设备非当前选择网点的设备，请核实", () {
            Application.router.pop(context);
          });
          return;
        }
        resList.forEach((val) {
          if (val.equipmentId == id) {
            val.status = 1;
          }
        });
        setState(() {});
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _submitReport() async {
    if (orgBranchStr == "") return showToast('请选择网点');
    Map params = new Map();
    params['orgBranchId'] = orgBranchId;
    Api.propertyCheckRecordCommit(formData: resList, map: params).then((res) {
      if (res.code == 1) {
        Navigator.pop(context, "init");
      }
      showToast(res.msg);
    });
  }

  _buildItem() {
    List<Widget> list = [];
    if(resList.length>0){
      resList.forEach((val) {
        list.add(GestureDetector(
          onTap: () {
//            setState(() {
//              val.status = val.status == 1 ? 2 : 1;
//            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: ColorUtil.color('#EEEEEE'),
                      width: ScreenUtil().setWidth(1))),
            ),
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(30),
                ScreenUtil().setHeight(28),
                ScreenUtil().setWidth(30),
                ScreenUtil().setHeight(28)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('编号：${val.equipmentNo}',
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                        )),
                    Text('    ${val.equipmentName}',
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                        ))
                  ],
                ),
                Container(
                  width: ScreenUtil().setWidth(32),
                  child: Image.asset(val.status == 1
                      ? 'lib/images/projectManager/normal_icon.png'
                      : 'lib/images/projectManager/not_counted_icon.png'),
                )
              ],
            ),
          ),
        ));
      });
    }else{
      list.add(Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Center(child: Text('暂无设备', style: TextStyle(
        color: ColorUtil.color('#666666'),
          fontSize: ScreenUtil().setSp(28),
        )),
      ),));
    }
    return list;
  }
}
