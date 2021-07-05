import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:bank_clean_flutter/models/materialApplyVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
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

class MaterielDetail extends StatefulWidget {
  final int id;

  const MaterielDetail({Key key, this.id}) : super(key: key);

  @override
  _MaterielDetailState createState() => _MaterielDetailState();
}

class _MaterielDetailState extends State<MaterielDetail> with ComPageWidget {
  bool isLoading = false;
  MaterialApplyVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料详情',
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
                                    Text(resData.title,
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
                                            resData.status == 1 ||
                                                    resData.status == 5
                                                ? '#FFE7E6'
                                                : (resData.status == 2
                                                    ? '#FFF4EC'
                                                    : (resData.status == 3
                                                        ? '#ECF1FF'
                                                        : '#f2f2f2'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text("${resData.statusText}",
                                          style: TextStyle(
                                              color: ColorUtil.color(
                                                  resData.status == 1 ||
                                                          resData.status == 5
                                                      ? '#CF241C'
                                                      : (resData.status == 2
                                                          ? '#CD8E5F'
                                                          : (resData.status == 3
                                                              ? '#375ECC'
                                                              : '#666666'))),
                                              fontSize: ScreenUtil().setSp(28),
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请人：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.cleanerName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请网点：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.organizationBranchName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请时间：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.createTime}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '申请原因：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.reason}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Offstage(
                                offstage: resData.reason != '其他',
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(40)),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(24),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(24)),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.color('#F5F6F9'),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  child: Text('${resData.mark}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ),
                              )
                            ],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('物料选择',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold)),
//                                  Offstage(
//                                    offstage: resData.status == 1||resData.status == 5,
//                                    child: Text('审核通过',
//                                        style: TextStyle(
//                                            color: ColorUtil.color('#CF241C'),
//                                            fontSize: ScreenUtil().setSp(28),
//                                            fontWeight: FontWeight.bold)),
//                                  ),
                                ],
                              ),
                              Column(
                                children: _materielItems(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: resData.status != 1,
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
                        child: Text(resData.status == 1 ? '修改' : '确认接受',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        onPressed: () {
                          if (resData.status == 1) {
                            /// 修改
                            _materielModify();
                          } else {
                            /// 确认接受
                            confirmModify();
                          }
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
    super.initState();

    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['id'] = widget.id;
    Api.getMaterialDetail(map: params).then((res) {
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

  List<Widget> _materielItems() {
    List<Widget> widgets = [];
    if (resData.materialApplyItemVOList != null) {
      resData.materialApplyItemVOList.forEach((val) {
        widgets.add(Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#F5F6F9'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('${val.toolsName}',
                            style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontSize: ScreenUtil().setSp(32),
                            )),
//                        Offstage(
//                          offstage: false,
//                          child: Container(
//                            padding: EdgeInsets.fromLTRB(
//                                ScreenUtil().setWidth(6),
//                                ScreenUtil().setHeight(0),
//                                ScreenUtil().setWidth(6),
//                                ScreenUtil().setHeight(0)),
//                            margin: EdgeInsets.only(
//                                left: ScreenUtil().setWidth(14)),
//                            decoration: BoxDecoration(
//                              color: ColorUtil.color('#CF241C'),
//                              borderRadius: BorderRadius.all(
//                                  Radius.circular(
//                                      ScreenUtil().setWidth(4))),
//                            ),
//                            child: Text('超额',
//                                style: TextStyle(
//                                  color: ColorUtil.color('#ffffff'),
//                                  fontSize: ScreenUtil().setSp(24),
//                                )),
//                          ),
//                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('申请${val.quantity}件',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        Offstage(
                          offstage: resData.status == 1 ||
                              resData.status == 4 ||
                              resData.status == 5 ||
                              resData.status == 6,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20)),
                            child: Text('通过${val.passQuantity}件',
                                style: TextStyle(
                                  color: ColorUtil.color('#CF241C'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      });
    }
    return widgets;
  }

  void _materielModify() {
    List<ToolsVO> list = [];
    resData.materialApplyItemVOList.forEach((val) {
      ToolsVO obj = new ToolsVO();
      obj.id = val.toolsId;
      obj.limitQuantity = val.toolsLimitQuantity;
      obj.name = val.toolsName;
      obj.image = val.toolsImage;
      obj.quantity = val.quantity;
      list.add(obj);
    });
    Provide.value<MaterialApplyProvide>(context).changeList(list);
    Provide.value<MaterialApplyProvide>(context)
        .changeReason(resData.reason, resData.mark);
    Provide.value<MaterialApplyProvide>(context).changeId(resData.id);

    /// 返回当前页刷新数据
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MaterielApply(),
        )).then((data) {
      if (data == 'init') {
        print('刷新detail');
        _getData();
      }
    });
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
}
