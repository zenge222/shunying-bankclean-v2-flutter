import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/materialApplyItem.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/provide.dart';

class MaterielApply extends StatefulWidget {
  @override
  _MaterielApplyState createState() => _MaterielApplyState();
}

class _MaterielApplyState extends State<MaterielApply> with ComPageWidget {
  bool isLoading = false;
  FocusNode blankNode = FocusNode();
  TextEditingController _reasonController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料申请',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: Provide<MaterialApplyProvide>(builder: (context, child, val) {
        String applyMark =
            Provide.value<MaterialApplyProvide>(context).applyMark;

        /// 更新成员频繁渲染 导致输入框重置
//        print('applyMark:'+applyMark);
        if (applyMark != '') {
          _reasonController.text = applyMark;
        }
        return GestureDetector(
          onTap: () {
            // 点击空白页面关闭键盘
//            FocusScope.of(context).requestFocus(blankNode);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(8)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('申请原因',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  var aa = ['新项目申请', '新装修导致', '长时间使用', '其他'];
                                  ResetPicker.showStringPicker(context,
                                      data: aa, normalIndex: 0, title: "选择原因",
                                      clickCallBack: (int index, var str) {
                                    _reasonController.text = "";
                                    Provide.value<MaterialApplyProvide>(context)
                                        .changeReason(str, '');
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        val.applyReason == ""
                                            ? '请选择'
                                            : val.applyReason,
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
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
                              )
                            ],
                          ),
                          Offstage(
                            offstage: val.applyReason != '其他',
                            child: Material(
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(56)),
                                child: TextField(
                                    controller: _reasonController,
                                    onChanged: (text) {},
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
                                      hintText: "请输入原因",
                                      border: InputBorder.none,
                                      hasFloatingPlaceholder: false,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24)),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(8)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('物料选择',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  Application.router.navigateTo(
                                      context, Routers.materielSelect,
                                      transition: TransitionType.inFromRight);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text('请选择',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
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
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(36)),
                            child: Column(
                              children: _buildList(context, val.applyList),
                            ),
                          ),
                        ],
                      ),
                    )
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
                  child: Text('申请提交',
                      style: TextStyle(
                        color: ColorUtil.color('#ffffff'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  onPressed: () {
                    submitMaterielApply();
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

//  String applyMark = Provide.value<MaterialApplyProvide>(context).applyMark;
  @override
  void initState() {
    /// 首次进入请求数据
    super.initState();
  }

  List<Widget> _buildList(BuildContext context, List<ToolsVO> applyList) {
    List<Widget> list = [];
    if (applyList != null) {
      applyList.forEach((val) {
        list.add(Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(32),
              ScreenUtil().setHeight(18),
              ScreenUtil().setWidth(32),
              ScreenUtil().setHeight(18)),
          decoration: BoxDecoration(
            color: ColorUtil.color('#F5F6F9'),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
          ),
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(val.name,
                      style: TextStyle(
                        color: ColorUtil.color('#333333'),
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  Offstage(
                    offstage: val.limitQuantity>=val.quantity,
                    child:  Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(10),
                          ScreenUtil().setHeight(2),
                          ScreenUtil().setWidth(10),
                          ScreenUtil().setHeight(2)),
                      decoration: BoxDecoration(
                        color: ColorUtil.color('#CF241C'),
                        borderRadius: BorderRadius.all(
                            Radius.circular(
                                ScreenUtil().setWidth(8))),
                      ),
                      child: Text('超额',
                          style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontSize: ScreenUtil().setSp(22),
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              Text('x${val.quantity}',
                  style: TextStyle(
                    color: ColorUtil.color('#666666'),
                    fontSize: ScreenUtil().setSp(32),
                  )),
            ],
          ),
        ));
      });
    }
    return list;
  }

  submitMaterielApply() {
    int materialId = Provide.value<MaterialApplyProvide>(context).materialId;
    String applyReason =
        Provide.value<MaterialApplyProvide>(context).applyReason;
    List<ToolsVO> applyList =
        Provide.value<MaterialApplyProvide>(context).applyList;
    if (applyReason == '') return showToast('请选择申请原因');
    if (applyReason == '其他') {
      if (_reasonController.text == "") {
        return showToast('请填写申请理由');
      }
    }
    if (applyList.length == 0) return showToast('请选择物料');
    Map params = new Map();
    params['toolsArray'] = applyList;
    params['reason'] = applyReason;
    params['mark'] = _reasonController.text;
    if (materialId == 0) {
      /// 添加
      _submitFuture(applyList, params);
    } else {
      /// 修改
      params['toolsApplyId'] = materialId;
      _submitFuture(applyList, params);
    }
  }

  Future _submitFuture(List<ToolsVO> list, Map map) async {
    Api.submitMaterialApply(formData: list, map: map).then((res) {
      showToast(res.msg);
      Navigator.of(context).pop('init');
    });
  }
}
