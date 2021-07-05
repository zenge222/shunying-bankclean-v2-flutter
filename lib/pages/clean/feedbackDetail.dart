import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/http/HttpServe.dart';
import 'package:bank_clean_flutter/models/feedbackVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FeedbackDetail extends StatefulWidget {
  final int id;

  const FeedbackDetail({Key key, this.id}) : super(key: key);

  @override
  _FeedbackDetailState createState() => _FeedbackDetailState();
}

class _FeedbackDetailState extends State<FeedbackDetail> with ComPageWidget {
  bool isLoading = false;
  List feedbackImages = [];
  List feedbackBigImages = [];
  FeedbackVO resData;

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
                                            resData.status == 2
                                                ? '#FFE7E6'
                                                : '#F2F2F2'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text(
                                          resData.status == 2 ? '待处理' : '已处理',
                                          style: TextStyle(
                                              color: ColorUtil.color(
                                                  resData.status == 2
                                                      ? '#CF241C'
                                                      : '#666666'),
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
                                      text: '巡检：',
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
                              Container(
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
                          offstage: resData.status == 2,
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
                    offstage: resData.status == 3,
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
                        child: Text('清扫完成',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        onPressed: () {
                          _photoClick(0);
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
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _getFeedbackDetail();
    print('id:' + widget.id.toString());
  }

  Future _getFeedbackDetail() async {
    Map params = new Map();
    params['id'] = widget.id;
    Api.getFeedbackDetail(map: params).then((res) {
      if (res.code == 1) {
        List list1 = [];
        List list2 = [];
        res.data.images.split(',').forEach((val) {
          list1.add(res.data.baseUrl + val);
        });
        res.data.resultImages.split(',').forEach((val) {
          list2.add(res.data.baseUrl + val);
        });
        setState(() {
          isLoading = false;
          resData = res.data;
          feedbackImages = list1;
          feedbackBigImages = list2;
        });
        print('status:' + res.data.status.toString());
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _submitFeedback() async {
    Map params = new Map();
    params['id'] = resData.id;
    Api.submitFeedback(map: params).then((res) {
      print(res.code);
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      } else {
        showToast(res.msg);
      }
    });
  }

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

  void _photoClick(int index) async {
    if (index == 0) {
      //请求权限
      if (Platform.isIOS) {
        PermissionStatus status = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.camera);
        if (status.value == 1) {
          _takePhoto();
        } else {
          //有可能是的第一次请求
          _takePhoto();
          showToast("请授予权限");
        }
      } else if (Platform.isAndroid) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler().requestPermissions(
                [PermissionGroup.location, PermissionGroup.camera]);
        if (permissions[PermissionGroup.camera] != PermissionStatus.granted) {
          showToast("请到设置中授予权限");
        } else {
          _takePhoto();
        }
      }
      return;
    }
  }

  /* 拍照 */
  Future _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 70, maxWidth: 800);
    if (pickedFile != null) {
      await HttpServe.uploadFile('config/upload/image', pickedFile.path)
          .then((res) {
        if (res['code'] == 1) {
          String image = res['data']['key'];
          Map params = new Map();
          params['id'] = widget.id;
          params['images'] = image;
          Api.submitFeedback(map: params).then((res) {
            Navigator.pop(context, 'init');
            showToast(res.msg);
          });
        } else {
          showToast(res['msg']);
        }
      });
    } else {
      showToast('上传失败，请重新上传');
    }
  }

  List<Widget> _bigImages(BuildContext context) {
    List<Widget> widgets = [];
    feedbackBigImages.forEach((val) {
      widgets.add(Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(val),
        ),
      ));
    });
    return widgets;
  }
}
