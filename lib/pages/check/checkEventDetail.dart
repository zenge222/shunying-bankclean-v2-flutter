import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/emergencyVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/check/checkEventReport.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckEventDetail extends StatefulWidget {
  final int id;

  const CheckEventDetail({Key key, this.id}) : super(key: key);

  @override
  _CheckEventDetailState createState() => _CheckEventDetailState();
}

/// 巡检+银行(不可处理)+?
class _CheckEventDetailState extends State<CheckEventDetail>
    with ComPageWidget {
  bool isLoading = false;
  List feedbackImages = [];
  List bigImages = [];
  EmergencyVO resData;
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '事件详情',
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
                                    Row(
                                      children: <Widget>[
                                        Text('${resData.title}',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
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
                                                    : '#f2f2f2'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setWidth(8))),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(10)),
                                          child: Text('${resData.statusText}',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      resData.status == 1
                                                          ? '#CF241C'
                                                          : '#666666'),
                                                  fontSize:
                                                      ScreenUtil().setSp(28),
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
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
                                      text: '${resData.organizationBranchName}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ])),
                              ),
                            ],
                          ),
                        ),

                        /// 详情
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

                        /// 处理结果
                        Offstage(
                          offstage: resData.status == 1,
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
                                Text('处理结果',
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
                                  child: Text('${resData.resultContent}',
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                                ),
                                Container(
                                  child: Wrap(
                                    children: _bigImgList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: resData.status == 2 || type == '4',
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
                                builder: (context) =>
                                    CheckEventReport(id: resData.id),
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
    String appType = await SharedPreferencesUtil.getType();
    Map params = new Map();
    params['id'] = widget.id;
    Api.getReportDetail(map: params).then((res) {
      if (res.code == 1) {
        List image1 = [];
        List image2 = [];
        res.data.images.split(',').forEach((val) {
          image1.add(res.data.baseUrl + val);
        });
        res.data.resultImages.split(',').forEach((val) {
          image2.add(res.data.baseUrl + val);
        });
        setState(() {
          type = appType;
          isLoading = false;
          resData = res.data;
          feedbackImages = image1;
          bigImages = image2;
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

  List<Widget> _bigImgList() {
    List<Widget> images = [];
    if (bigImages.length == 0) return images;
    for (int i = 0; i < bigImages.length; i++) {
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
                    images: bigImages, index: i, heroTag: 'simple'),
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
                bigImages[i],
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
