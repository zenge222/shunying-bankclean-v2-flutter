import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'dart:convert' as convert;
import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/orgToolsApplyInfoVO.dart';
import 'package:bank_clean_flutter/models/toolsApplyItemVO.dart';
import 'package:bank_clean_flutter/models/toolsApplyVO.dart';
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

class MaterielExamineDetail extends StatefulWidget {
  final int id;

  const MaterielExamineDetail({Key key, this.id}) : super(key: key);

  @override
  _MaterielExamineDetailState createState() => _MaterielExamineDetailState();
}

class _MaterielExamineDetailState extends State<MaterielExamineDetail>
    with ComPageWidget {
  bool isLoading = false;
  OrgToolsApplyInfoVO resData;
  List<ToolsApplyVO> resList;
  bool isCheckAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点物料详情',
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
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(36),
                        ScreenUtil().setHeight(26),
                        ScreenUtil().setWidth(36),
                        ScreenUtil().setHeight(26)),
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          resData.orgBranchImage,
                          width: ScreenUtil().setWidth(52),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(12)),
                          child: Text('${resData.orgBranchName}',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(36),
                              )),
                        )
                      ],
                    ),
                  ),

                  /// 内容
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
                      child: Column(
                        children: _buildList(),
                      ),
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(16),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(16)),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _selAll();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(70)),
                            child: Row(
                              children: <Widget>[
                                isCheckAll
                                    ? Image.asset(
                                        'lib/images/check/checked_box.png',
                                        width: ScreenUtil().setWidth(40),
                                      )
                                    : Image.asset(
                                        'lib/images/check/check_box.png',
                                        width: ScreenUtil().setWidth(40),
                                      ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(12)),
                                  child: Text('全选',
                                      style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10)),
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
                                child: Text('清零',
                                    style: TextStyle(
                                      color: ColorUtil.color('#CF241C'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                                onPressed: () {
                                  _clearAll();
                                },
                              ),
                            )),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10)),
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
                                child: Text('确认',
                                    style: TextStyle(
                                      color: ColorUtil.color('#ffffff'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                                onPressed: () {
                                  /// 全部提交
                                  _submitDetail();
                                },
                              ),
                            )),
                          ],
                        ))
                      ],
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
    super.initState();
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['orgBranchId'] = widget.id;
    Api.getToolsOrgBranchDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
          resList = res.data.applyVOList;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    for (int i = 0; i < resList.length; i++) {
      list.add(Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(32),
            ScreenUtil().setHeight(24),
            ScreenUtil().setWidth(32),
            ScreenUtil().setHeight(0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${resList[i].cleanerName}',
                      style: TextStyle(
                        color: ColorUtil.color('#333333'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(36),
                      )),
                  Text('${resList[i].createTime}',
                      style: TextStyle(
                        color: ColorUtil.color('#666666'),
                        fontSize: ScreenUtil().setSp(32),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(resList[i].mark != '' ? 0 : 20)),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '申请原因：',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        fontWeight: FontWeight.bold,
                        color: ColorUtil.color('#333333'))),
                TextSpan(
                    text: '${resList[i].reason}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: ColorUtil.color('#666666'))),
              ])),
            ),
            Offstage(
              offstage: resList[i].mark == '',
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(40),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(40)),
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(24),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(24)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#F5F6F9'),
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                ),
                child: Text('${resList[i].mark}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: ColorUtil.color('#333333'))),
              ),
            ),
            Column(
              children: _selBuild(context, resList[i].materialApplyItemVOList),
            )
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> _selBuild(
      BuildContext context, List<ToolsApplyItemVO> materialList) {
    List<Widget> list = [];
    for (int j = 0; j < materialList.length; j++) {
      list.add(Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(32),
              ScreenUtil().setHeight(28),
              ScreenUtil().setWidth(32),
              ScreenUtil().setHeight(28)),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: ColorUtil.color('#EAEAEA'),
                width: ScreenUtil().setWidth(1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (materialList[j].checked == 1) {
                          materialList[j].checked = 2;
                        } else {
                          materialList[j].checked = 1;
                        }
                      });
                    },
                    child: Container(
                      child: materialList[j].checked == 1
                          ? Image.asset(
                              'lib/images/check/check_box.png',
                              width: ScreenUtil().setWidth(40),
                            )
                          : Image.asset(
                              'lib/images/check/checked_box.png',
                              width: ScreenUtil().setWidth(40),
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                    child: Text('${materialList[j].toolsName}',
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(32),
                        )),
                  ),
                  Offstage(
                    offstage: materialList[j].toolsLimitQuantity -
                            materialList[j].passQuantity >=
                        0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(6),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(6),
                          ScreenUtil().setHeight(0)),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(14)),
                      decoration: BoxDecoration(
                        color: ColorUtil.color('#CF241C'),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(4))),
                      ),
                      child: Text('超额',
                          style: TextStyle(
                            color: ColorUtil.color('#ffffff'),
                            fontSize: ScreenUtil().setSp(24),
                          )),
                    ),
                  )
                ],
              ),
              Container(
                height: ScreenUtil().setHeight(56),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  border:
                      Border.all(color: ColorUtil.color('#d1d1d1'), width: 0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _minusNum(materialList[j]);
                      },
                      child: Container(
                        width: 32.0,
                        color: Color(0xfff5f5f5),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'lib/images/clean/icon-minus.png',
                          width: ScreenUtil().setWidth(24),
                        ), // 设计图
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(1),
                      color: ColorUtil.color('#d1d1d1'),
                    ),
                    Container(
                      width: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        '${materialList[j].passQuantity}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(1),
                      color: ColorUtil.color('#d1d1d1'),
                    ),
                    GestureDetector(
                      onTap: () {
                        _addNum(materialList[j]);
                      },
                      child: Container(
                        color: Color(0xfff5f5f5),
                        width: 32.0,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'lib/images/clean/icon-plus.png',
                          width: ScreenUtil().setWidth(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )));
    }
    return list;
  }

  void _minusNum(ToolsApplyItemVO materialList) {
    if (materialList.passQuantity != 0) {
      setState(() {
        materialList.passQuantity -= 1;
      });
    }
  }

  void _addNum(ToolsApplyItemVO materialList) {
    setState(() {
      materialList.passQuantity += 1;
    });
  }

  void _selAll() {
    setState(() {
      isCheckAll = !isCheckAll;
    });
    if (isCheckAll) {
      resList.forEach((val) {
        val.materialApplyItemVOList.forEach((val) {
          setState(() {
            val.checked = 2;
          });
        });
      });
    } else {
      resList.forEach((val) {
        val.materialApplyItemVOList.forEach((val) {
          setState(() {
            val.checked = 1;
          });
        });
      });
    }
  }

  void _clearAll() {
    resList.forEach((val) {
      val.materialApplyItemVOList.forEach((val) {
        if (val.checked == 2) {
          setState(() {
            val.passQuantity = 0;
          });
        }
      });
    });
  }

  Future _submitDetail() async {
//    String json = convert.jsonEncode(resData);
//    print(json);
  print(resData.applyVOList[0].materialApplyItemVOList[0].passQuantity.toString());
    Api.toolsApplyEdit(formData: resData).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      }
      showToast(res.msg);
    });
  }
}
