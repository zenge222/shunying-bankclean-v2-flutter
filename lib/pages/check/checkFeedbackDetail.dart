import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/feedbackVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/common/cleanSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckFeedbackDetail extends StatefulWidget {
  final int id;

  const CheckFeedbackDetail({Key key, this.id}) : super(key: key);

  @override
  _CheckFeedbackDetailState createState() => _CheckFeedbackDetailState();
}

/// 区域经理 + 银行(不可分配)
class _CheckFeedbackDetailState extends State<CheckFeedbackDetail>
    with ComPageWidget {
  bool isLoading = false;
  List feedbackImages = [];
  List feedbackBigImages = [];
  FeedbackVO resData;
  int cleanerId = 0;
  String cleanerStr = '';
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '清扫反馈详情',
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
                                                    ? '#FFF4EC'
                                                    : '#f2f2f2')),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text(
                                          resData.status == 1
                                              ? '待分配'
                                              : (resData.status == 2
                                                  ? '待处理'
                                                  : '已处理'),
                                          style: TextStyle(
                                              color: ColorUtil.color(
                                                  resData.status == 1
                                                      ? '#CF241C'
                                                      : (resData.status == 2
                                                          ? '#CD8E5F'
                                                          : '#666666')),
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
                                      text: '地点：',
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
                                      text: '指派人员：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.areaManagerName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Offstage(
                                offstage: resData.status == 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '保洁：',
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
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '反馈时间：',
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
                              Offstage(
                                offstage: resData.dispatchTime == null,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '指派时间：',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(32),
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '${resData.dispatchTime}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                  ])),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '说明：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '${resData.content}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: Wrap(
                                  children: _imgList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: resData.status != 1 || type == '4',
                          child: Container(
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
                                Text('工作指派',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text('保洁员',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                ))),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CleanSelect(
                                                    id: widget.id,
                                                    type: 3,
                                                    feedbackId: resData.id,
                                                  ),
                                                )).then((data) {
                                              if (data != null) {
                                                print('改变数据');
                                                setState(() {
                                                  cleanerId = data.id;
                                                  cleanerStr = data.name;
                                                });
                                              }
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                  cleanerStr == ""
                                                      ? '请选择'
                                                      : cleanerStr,
                                                  style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#666666'),
                                                    fontSize:
                                                        ScreenUtil().setSp(32),
                                                  )),
                                              Container(
                                                width:
                                                    ScreenUtil().setWidth(32),
                                                margin: EdgeInsets.only(
                                                    left: ScreenUtil()
                                                        .setWidth(24)),
                                                child: Image.asset(
                                                    'lib/images/clean/sel_right.png'),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        /// 清扫结果
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
                                Text('清扫结果',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Column(
                                  children: _bigImages(context),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: resData.status != 1 || type == '4',
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
                        child: Text('确定分配',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        onPressed: () {
                          _distributeSubmit();
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
    _getFeedbackDetail();
  }

  Future _getFeedbackDetail() async {
    String appType = await SharedPreferencesUtil.getType();
    Map params = new Map();
    params['id'] = widget.id;
    Api.getFeedbackDetail(map: params).then((res) {
      List images = [];
      List images2 = [];
      if (res.code == 1) {
        if (res.data.images != '') {
          res.data.images.split(',').forEach((val) {
            images.add(res.data.baseUrl + val);
          });
        }
        if (res.data.resultImages != '') {
          res.data.resultImages.split(',').forEach((val) {
            images2.add(res.data.baseUrl + val);
          });
        }
        setState(() {
          type = appType;
          isLoading = false;
          resData = res.data;
          feedbackImages = images;
          feedbackBigImages = images2;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _distributeSubmit() async {
    if (cleanerStr == "") {
      showToast('请选择保洁');
    } else {
      Map params = new Map();
      params['id'] = widget.id;
      params['cleanerId'] = cleanerId;
      Api.feedbackDispatch(map: params).then((res) {
        if (res.code == 1) {
          Navigator.pop(context, 'init');
        }
        showToast(res.msg);
      });
    }
  }

//  Future _submitFeedback() async {
//    Map params = new Map();
//    params['id'] = resData.id;
//    Api.submitFeedback(map: params).then((res) {
//      print(res.code);
//      if (res.code == 1) {
//        Navigator.of(context).pop('init');
//      } else {
//        showToast(res.msg);
//      }
//    });
//  }

  List<Widget> _imgList() {
    List<Widget> images = [];
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

  List<Widget> _bigImages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < feedbackBigImages.length; i++) {
      widgets.add(GestureDetector(
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
                  images: feedbackBigImages, index: i, heroTag: 'simple'),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(feedbackBigImages[i]),
          ),
        ),
      ));
    }
    return widgets;
  }
}
