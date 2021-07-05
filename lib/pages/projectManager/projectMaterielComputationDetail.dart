import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/materialApplyVO.dart';
import 'package:bank_clean_flutter/models/toolsApplyItemVO.dart';
import 'package:bank_clean_flutter/models/toolsCheckRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
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

class ProjectMaterielComputationDetail extends StatefulWidget {
  final int id;

  const ProjectMaterielComputationDetail({Key key, this.id}) : super(key: key);

  @override
  _ProjectMaterielComputationDetailState createState() =>
      _ProjectMaterielComputationDetailState();
}

/// 主管 区域经理
class _ProjectMaterielComputationDetailState
    extends State<ProjectMaterielComputationDetail> with ComPageWidget {
  bool isLoading = false;
  ToolsCheckRecordVO resData;

  /// 1:通过，2拒绝
  int submitType = 1;
  String content = '';
  String type = ''; //  1 保洁 2 领班 3 主管 4 银行人员 5 区域经理 6 维修工

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料单详情',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        // 默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: resData != null
            ? Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(40),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(40)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('${resData.title}',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2),
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2)),
                                      decoration: BoxDecoration(
                                        color: ColorUtil.color(
                                            resData.status == 1
                                                ? '#FFE7E6'
                                                : (resData.status == 2
                                                    ? '#ECF1FF'
                                                    : (resData.status == 3
                                                        ? '#f2f2f2'
                                                        : '#f2f2f2'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text('${resData.statusText}',
                                          style: TextStyle(
                                              color: ColorUtil.color(
                                                  resData.status == 1
                                                      ? '#CF241C'
                                                      : (resData.status == 2
                                                          ? '#375ECC'
                                                          : (resData.status == 3
                                                              ? '#666666'
                                                              : '#666666'))),
                                              fontSize: ScreenUtil().setSp(28),
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(50)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('提交人：${resData.areaManagerName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    Text('${resData.createTime}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: resData.status != 3,
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
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(40)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('驳回原因',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(32)),
                                  child: Text('${resData.reason}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                )
                              ],
                            ),
                          ),
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
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(40),
                              ScreenUtil().setWidth(0),
                              ScreenUtil().setHeight(40)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(20),
                                        left: ScreenUtil().setHeight(32)),
                                    child: Text('物料明细',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold)),
                                  ),
//                                  Offstage(
//                                    offstage: resData.status == 1,
//                                    child: Text('审核通过',
//                                        style: TextStyle(
//                                            color: ColorUtil.color('#CF241C'),
//                                            fontSize: ScreenUtil().setSp(28),
//                                            fontWeight: FontWeight.bold)),
//                                  ),
                                ],
                              ),
                              Column(
                                children: materielItems(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: resData.status == 3,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(16),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(26),
                            ),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: '总计成本：',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(24),
                                  )),
                              TextSpan(
                                  text: '¥${resData.sumCost}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#CF241C'),
                                    fontSize: ScreenUtil().setSp(36),
                                  )),
                            ])),
                          ),
                          Offstage(
                            offstage: resData.status != 1 || type == "3",
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(16)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(13)),
                                    child: FlatButton(
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(20),
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(20)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(60))),
                                      color: ColorUtil.color('#EAEAEA'),
                                      child: Text('拒绝',
                                          style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(32),
                                          )),
                                      onPressed: () {
                                        setState(() {
                                          submitType = 2;
                                        });
                                        _refuse(context);
                                      },
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(13)),
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
                                      child: Text('通过',
                                          style: TextStyle(
                                            color: ColorUtil.color('#ffffff'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(32),
                                          )),
                                      onPressed: () {
                                        setState(() {
                                          submitType = 1;
                                        });
                                        _submitDetail(context);
                                      },
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          )
                        ],
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
    super.initState();
    setState(() {
      isLoading = true;
    });
    _getType();
    _getData();
  }

  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  Future _getData() async {
    Map params = new Map();
    params['id'] = widget.id;
    Api.toolsCheckRecordDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> materielItems() {
    List<Widget> widgets = [];

    widgets.add(Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
      color: ColorUtil.color('#FAFAFA'),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            child: Text('物料',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ),
          Container(
            width: ScreenUtil().setWidth(116),
            child: Text('配额',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ),
          Container(
            width: ScreenUtil().setWidth(116),
            child: Text('申领',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ),
          Container(
            width: ScreenUtil().setWidth(116),
            child: Text('剩余',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ),
          Expanded(
              child: Container(
            child: Text('成本',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ))
        ],
      ),
    ));
    if (resData.itemList != null) {
      List<ToolsApplyItemVO> resList = resData.itemList;

      for (int i = 0; i < resList.length; i++) {
        widgets.add(Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                color: ColorUtil.color('#ffffff'),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(180),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(90),
                            child: Text('${resList[i].toolsName}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setHeight(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Offstage(
                                  offstage: resList[i].sumLimitQuantity -
                                          resList[i].sumPassQuantity >
                                      0,
                                  child: Container(
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
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(116),
                      child: Text('${resList[i].sumLimitQuantity}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(116),
                      child: Text('${resList[i].sumPassQuantity}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(116),
                      child: Text('${resList[i].remaining}',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Expanded(
                        child: Container(
                      child: Text('¥${resList[i].sumCost}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
      }
    }
    return widgets;
  }

  Future confirmModify() async {
    Map params = new Map();
    params['id'] = resData.id;
    Api.confirmMaterialApply(map: params).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      }
      showToast(res.msg);
    });
  }

  Future _submitDetail(BuildContext context) async {
    Map params = new Map();
    params['recordId'] = widget.id;
    params['status'] = submitType;
    if (submitType == 2) {
      params['content'] = content;
    }
    Api.toolsCheckRecordSubmit(map: params).then((res) {
      if (res.code == 1) {
        if (submitType == 2) {
          Navigator.pop(context);
        }
        Navigator.pop(context, 'init');
      }
      showToast(res.msg);
    });
  }

  void _refuse(BuildContext context) {
    showDialog<Null>(
        context: context,
        // 点击背景区域是否可以关闭
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: ScreenUtil().setWidth(600),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#FDFAFE'),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          bottom: ScreenUtil().setHeight(20)),
                      child: Text(
                        '拒绝原因',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(36),
                            color: Color.fromRGBO(0, 0, 0, 0.8)),
                      ),
                    ),

                    /// 详情
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(24),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(24),
                          ScreenUtil().setHeight(0)),
                      decoration: BoxDecoration(
                        color: ColorUtil.color('#F5F6F9'),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(8))),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                            child: Container(
                              width: double.infinity,
                              child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      content = text;
                                    });
                                  },
                                  inputFormatters: <TextInputFormatter>[
//                                    WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                                    LengthLimitingTextInputFormatter(300)
                                    //限制长度
                                  ],
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      textBaseline: TextBaseline.alphabetic),
                                  decoration: InputDecoration(
                                    fillColor: ColorUtil.color('#F5F6F9'),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(
                                      ScreenUtil().setSp(20),
                                    ),
                                    hintText: "请输入拒绝原因",
                                    border: InputBorder.none,
                                    hasFloatingPlaceholder: false,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),

                    /// 底部操作
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: ColorUtil.color('#ededed'))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#EAEAEA'),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        ScreenUtil().setWidth(14))),
                              ),
                              child: OutlineButton(
                                onPressed: () async {
                                  Application.router.pop(context);
                                },
                                borderSide: BorderSide.none,
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: ColorUtil.color('#333333')),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#CF241C'),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        ScreenUtil().setWidth(14))),
                              ),
                              child: OutlineButton(
                                onPressed: () async {
                                  if (content == "")
                                    return showToast('请输入拒绝原因');
                                  setState(() {
                                    submitType = 2;
                                  });
                                  _submitDetail(context);
                                },
                                borderSide: BorderSide.none,
                                child: Text(
                                  '确定',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: ColorUtil.color('#ffffff')),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
