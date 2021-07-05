import 'dart:convert';
import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/http/HttpServe.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckMachineInspect extends StatefulWidget {
  @override
  _CheckMachineInspectState createState() => _CheckMachineInspectState();
}

/// 领班
class _CheckMachineInspectState extends State<CheckMachineInspect>
    with ComPageWidget {
  bool isLoading = false;
  FocusNode blankNode = FocusNode();
  String content = '';
  int orgBranchId = 0;
  String orgBranchStr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '保养检查',
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
                                });
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
                    Container(
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
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(40),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(40)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('检查情况',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                          Material(
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40)),
                              child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      content = text;
                                    });
                                  },
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontSize: 14,
                                      textBaseline: TextBaseline.alphabetic),
                                  decoration: InputDecoration(
                                    fillColor: ColorUtil.color('#F5F6F9'),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(
                                      ScreenUtil().setSp(20),
                                    ),
                                    hintText: "请描述具体信息",
                                    border: InputBorder.none,
                                    hasFloatingPlaceholder: false,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              Container(
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
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(60))),
                  color: ColorUtil.color('#CF241C'),
                  child: Text('提交',
                      style: TextStyle(
                        color: ColorUtil.color('#ffffff'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  disabledColor: ColorUtil.color('#E1E1E1'),
                  onPressed: orgBranchStr != "" && content != "" ? () {
                    _submitReport();
                  } : null,
                ),
              )
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


  Future _submitReport() async {
    if (orgBranchStr == "") return showToast('请选择网点');
    if (content == "") return showToast('请填写描述');
    setState(() {
      isLoading = true;
    });
    Map params = new Map();
    params['content'] = content;
    params['orgBranchId'] = orgBranchId;
    Api.equipmentMaintainRecordCommit(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context,"init");
      }
      showToast(res.msg);
    });
  }
}
