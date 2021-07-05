import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckNoticeDetail extends StatefulWidget {
  final int id;

  const CheckNoticeDetail({Key key, this.id}) : super(key: key);

  @override
  _CheckNoticeDetailState createState() => _CheckNoticeDetailState();
}

class _CheckNoticeDetailState extends State<CheckNoticeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '巡检通知详情',
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
        isLoading: false,
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
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('审核通知详情',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                          Text('2020.11.16  14:00',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(32),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child:
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '您已',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(32),
                                   )),
                            TextSpan(
                                text: '10',
                                style: TextStyle(
                                  color: ColorUtil.color('#CF241C'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                            TextSpan(
                                text: '天未巡检奉贤支行',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                          ])),
                    ),
                  ],
                ),
              ),

              /// 按钮
              Center(
                child: Container(
                  child: Container(
                    width: ScreenUtil().setWidth(336),
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(52)),
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
                      child: Text('去巡检',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(32),
                          )),
                      onPressed: () {
                        /// 全部提交
                        Navigator.of(context).pop('init');
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
