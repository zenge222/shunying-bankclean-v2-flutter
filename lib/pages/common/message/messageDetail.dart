import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/emergencyVO.dart';
import 'package:bank_clean_flutter/models/messageVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/check/checkEventReport.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageDetail extends StatefulWidget {
  final int id;
  final int type; // 1：事件上报，2：物料审核通知，3:网点巡检提醒
  final String title;

  const MessageDetail({Key key, this.id, this.title, this.type})
      : super(key: key);

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> with ComPageWidget {
  bool isLoading = false;
  List feedbackImages = [];
  MessageVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '${widget.title}',
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
        child: Column(
          children: <Widget>[
            resData != null
                ? Expanded(
                    child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// 事件上报
                        Offstage(
                          offstage: widget.type != 1,
                          child: Container(
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
                                      Text('${resData.createTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '上报人：',
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
                                        text: '网点：',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(32),
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            '${resData.organizationBranchName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                  ])),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 事件上报 详情
                        Offstage(
                          offstage: widget.type != 1,
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
                                Text('详情',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(32),
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(32)),
                                  child: Text('${resData.content}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ),
                                Container(
                                  child: Wrap(
                                    children: _imgList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /*           审核通知详情              */
                        Offstage(
                          offstage: widget.type != 2,
                          child: Container(
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
                                      Text('${resData.createTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Text('${resData.subTitle}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: widget.type != 2,
                          child: Offstage(
                            offstage: resData.auditStatus == 1,
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('原因',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(32)),
                                          child: Text('${resData.content}',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#666666'),
                                                fontSize:
                                                    ScreenUtil().setSp(32),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// 按钮
                        Offstage(
                          offstage: widget.type != 2,
                          child: Center(
                            child: Container(
                              child: Container(
                                width: ScreenUtil().setWidth(336),
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(52)),
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
                                  child: Text('查看',
                                      style: TextStyle(
                                        color: ColorUtil.color('#CF241C'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                  onPressed: () {
//                                  print(resData.auditStatus);
//                                  print(resData.type);
                                    int subIndex =
                                        resData.auditStatus == 1 ? 1 : 2;
                                    /// 跳转  审核列表  未通过
                                    Application.router.navigateTo(
                                        context,
                                        Routers.checkComputationList +
                                            '?index=${subIndex}',
                                        transition: TransitionType.inFromRight,
                                        replace: true);

//                                   Navigator.of(context).pop('init');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*           巡检通知详情           */
                        Offstage(
                          offstage: widget.type != 3,
                          child: Container(
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
                                      Text('${resData.createTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(32),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '您已',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    TextSpan(
                                        text: '${resData.days}天未巡检',
                                        style: TextStyle(
                                          color: ColorUtil.color('#CF241C'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    TextSpan(
                                        text:
                                            '${resData.organizationBranchName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                  ])),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 按钮
                        Offstage(
                          offstage: widget.type != 3,
                          child: Center(
                            child: Container(
                              child: Container(
                                width: ScreenUtil().setWidth(336),
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(52)),
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
                                    Application.router.navigateTo(
                                        context, Routers.onlineInspectionList,
                                        transition: TransitionType.inFromRight,
                                        replace: true);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                : Text(''),

            /// 事件处理按钮
            Offstage(
              offstage: true, //widget.type != 1,
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
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(60))),
                  color: ColorUtil.color('#CF241C'),
                  child: Text('处理',
                      style: TextStyle(
                        color: ColorUtil.color('#ffffff'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckEventReport(id: widget.id),
                        )).then((data) {
                      if (data == 'init') {
                        _getData();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
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
    params['id'] = widget.id;
    Api.getMessageDetail(map: params).then((res) {
      if (res.code == 1) {
        List images = [];
        if (res.data.images != '' && res.data.images != null) {
          res.data.images.split(',').forEach((val) {
            images.add(res.data.baseUrl + val);
          });
        }
        setState(() {
          isLoading = false;
          resData = res.data;
          feedbackImages = images;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _imgList() {
    List<Widget> images = [];
    if (feedbackImages.length == 0) return images;
    for (int i = 0; i < feedbackImages.length; i++) {
      images.add(
        GestureDetector(
          onTap: () {
            //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
            /* Navigator.of(context).push(new MaterialPageRoute(page: PhotoViewGalleryScreen(
              images: newImgArr,//传入图片list
              index: i,//传入当前点击的图片的index
              heroTag: 'simple',//传入当前点击的图片的hero tag （可选）
            )));*/
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewGalleryScreen(
                    images: feedbackImages, index: i, heroTag: 'simple'),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(10),
                ScreenUtil().setHeight(30),
                ScreenUtil().setWidth(10),
                ScreenUtil().setHeight(10)),
            child: ClipRRect(
              child: Image.network(
                feedbackImages[i],
                width: ScreenUtil().setWidth(187),
                height: ScreenUtil().setHeight(187),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
    }
    return images;
  }
}
