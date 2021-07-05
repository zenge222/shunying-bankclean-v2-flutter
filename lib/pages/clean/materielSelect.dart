import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/ToolsVO.dart';
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

class MaterielSelect extends StatefulWidget {
  @override
  _MaterielSelectState createState() => _MaterielSelectState();
}

class _MaterielSelectState extends State<MaterielSelect> with ComPageWidget {
  bool isLoading = false;
  FocusNode blankNode = FocusNode();
  String searchName = "";
  List<ToolsVO> allList = [];
  List<ToolsVO> resList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料选择',
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
        isLoading: false,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(30),
                  ScreenUtil().setHeight(16),
                  ScreenUtil().setWidth(30),
                  ScreenUtil().setHeight(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(10),
                          ScreenUtil().setWidth(30),
                          ScreenUtil().setHeight(0)),
//                    width: ScreenUtil().setWidth(530.0),
                      height: ScreenUtil().setHeight(70.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setWidth(5))),
                        color: ColorUtil.color('#ffffff'),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setHeight(0)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#F8F8FA'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(36))),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            searchName = text;
                          },
                          decoration: InputDecoration(
                            icon: Container(
                                padding: EdgeInsets.all(0),
                                child: Image.asset(
                                  'lib/images/clean/search_icon.png',
                                  width: ScreenUtil().setWidth(32),
                                )),
                            contentPadding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0)),
                            hintText: "请输入物料名称",
                            hintStyle: TextStyle(
                                color: ColorUtil.color('#999999'),
                                fontSize: ScreenUtil().setSp(28)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 0,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ColorUtil.color('#F8F8FA'),
                              width: 0,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _searchListData();
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(96),
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(0),
                          bottom: ScreenUtil().setHeight(10),
                          right: ScreenUtil().setWidth(0),
                        ),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#CF241C'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(28))),
                        ),
                        child: Text(
                          '搜索',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 列表
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(0),
                  left: ScreenUtil().setWidth(32),
                  bottom: ScreenUtil().setHeight(0),
                  right: ScreenUtil().setWidth(32),
                ),
                child: Column(
                  children: _items(context),
                ),
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
                child: Text('确定',
                    style: TextStyle(
                      color: ColorUtil.color('#ffffff'),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                    )),
                onPressed: () {
                  _submitSel(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _items(BuildContext context) {
    List<Widget> widgets = [];
    if (resList != null) {
      if (resList.length != 0) {
        for (int i = 0; i < resList.length; i++) {
          widgets.add(Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(16))),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(
                            resList[i].image,
                            width: ScreenUtil().setWidth(140),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Container(
                                     width:ScreenUtil().setWidth(150),
                                     child: Text('${resList[i].name}',
                                         maxLines: 2,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: ColorUtil.color('#333333'),
                                           fontWeight: FontWeight.bold,
                                           fontSize: ScreenUtil().setSp(30),
                                         )),
                                   ),
                                   Offstage(
                                     offstage: resList[i].limitQuantity-resList[i].quantity>=0,
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
                                   ),
                                 ],
                               ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(12)),
                                  child:
                                      Text('剩余配额：${resList[i].limitQuantity}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(28),
                                          )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: ScreenUtil().setHeight(56),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          border: Border.all(
                              color: ColorUtil.color('#d1d1d1'), width: 0.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _minusNum(resList[i], i);
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
                                '${resList[i].quantity}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ),
//                            Offstage(
//                              offstage: true,
//                              child: Container(
//                                width: 50,
//                                alignment: Alignment.center,
//                                child: TextField(
//                                    style: TextStyle(
//                                        fontSize: ScreenUtil().setSp(36),
//                                        fontWeight: FontWeight.bold,
//                                        color: ColorUtil.color('#333333')
//                                    ),
//                                    keyboardType: TextInputType.number,//限定数字键盘
//                                    inputFormatters: <TextInputFormatter>[
//                                      WhitelistingTextInputFormatter.digitsOnly
//                                    ], //// 限定数字输入
//                                    decoration: InputDecoration(
//                                      hintStyle: TextStyle(
//                                          color: ColorUtil.color('#999999'),
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: ScreenUtil().setSp(36)),
//                                      enabledBorder: OutlineInputBorder(
//                                          borderSide: BorderSide(
//                                            color: ColorUtil.color('#F8F8FA'),
//                                            width: 0,
//                                          )),
//                                      focusedBorder: OutlineInputBorder(
//                                          borderSide: BorderSide(
//                                            color: ColorUtil.color('#F8F8FA'),
//                                            width: 0,
//                                          )),
//                                    )
//                                ),
//                              ),
//                            ),
                            Container(
                              width:ScreenUtil().setWidth(1),
                              color: ColorUtil.color('#d1d1d1'),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addNum(resList[i], i);
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
                  ),
                ),

              ],
            ),
          ));
        }
      }
    }
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _firstListData();
  }

  Future _firstListData() async {
    Map params = new Map();
    params['name'] = searchName;
    Api.getMateriaSleelectList(map: params).then((res) {
      if (res.code == 1) {
        /// 处理数据
        List<ToolsVO> pList =
            Provide.value<MaterialApplyProvide>(context).applyList;
        List<ToolsVO> list = res.list;
        list.forEach((val){
          val.image = val.baseUrl + val.image;
        });
        pList.forEach((item1) {
          for (int i = 0; i < list.length; i++) {
            if (item1.id == list[i].id) {
              list[i].quantity = item1.quantity;
            }
          }
        });
        setState(() {
          isLoading = false;
          allList = list;
          resList = list;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _searchListData() async {
    Map params = new Map();
    params['name'] = searchName;
    Api.getMateriaSleelectList(map: params).then((res) {
      if (res.code == 1) {
        /// 处理数据
        List<ToolsVO> pList =
            Provide.value<MaterialApplyProvide>(context).applyList;
        List<ToolsVO> list = res.list;
        list.forEach((val){
          val.image = val.baseUrl + val.image;
        });
        pList.forEach((item1) {
          for (int i = 0; i < list.length; i++) {
            if (item1.id == list[i].id) {
              list[i].quantity = item1.quantity;
            }
          }
        });
        setState(() {
          resList = list;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  _minusNum(ToolsVO item, int index) {
    if (item.quantity != 0) {
      setState(() {
        item.quantity -= 1;
      });
    }
  }

  _addNum(ToolsVO item, int index) {
    setState(() {
      item.quantity += 1;
    });
  }

  void _submitSel(BuildContext context) {
    List<ToolsVO> selList = [];
    allList.forEach((val) {
      if (val.quantity != 0) {
        selList.add(val);
      }
    });
    Provide.value<MaterialApplyProvide>(context).changeList(selList);
    Application.router.pop(context);
  }
}
