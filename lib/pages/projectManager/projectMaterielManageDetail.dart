import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectMaterielManageDetail extends StatefulWidget {
  final int id;

  const ProjectMaterielManageDetail({Key key, this.id}) : super(key: key);

  @override
  _ProjectMaterielManageDetailState createState() =>
      _ProjectMaterielManageDetailState();
}

class _ProjectMaterielManageDetailState
    extends State<ProjectMaterielManageDetail> with ComPageWidget {
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料明细',
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(32),right: ScreenUtil().setWidth(32)),
            child: Column(
              children: <Widget>[
                /// 头部
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(36)),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#ffffff'),
                    borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('浦东大片区'),
                      Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),child:  RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '区域经理：',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                            TextSpan(
                                text: '李某',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),

                          ])),)
                    ],
                  ),
                ),
                /// 物料明细
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('物料明细',style: TextStyle(
                        color: ColorUtil.color('#333333'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(36),
                      )),
                      GestureDetector(
                        onTap: () {
                          DateTime today = DateTime.now();
                          ResetPicker.showDatePicker(context,
                              dateType: DateType.YM,
                              minValue: DateTime(today.year - 1),
                              maxValue: DateTime(today.year + 1,today.month,today.day),
                              clickCallback: (var str, var time) {
                                print(str);
                                print(time);
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(28),
                              ScreenUtil().setHeight(8),
                              ScreenUtil().setWidth(28),
                              ScreenUtil().setHeight(8)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#ffffff'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(22))),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '2020-07',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(28)),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(4)),
                                width: ScreenUtil().setWidth(24),
                                child: Image.asset(
                                    'lib/images/clean/triangle_down.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// 列表
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#ffffff'),
                    borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(10),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(87),
                            ScreenUtil().setHeight(80)),
                        child: Text('打个锤子'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;

      /// 临时设置
    });
  }
}
