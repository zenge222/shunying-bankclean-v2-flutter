import 'dart:convert';
import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/http/HttpServe.dart';
import 'package:bank_clean_flutter/models/cleanerHomeVO.dart';
import 'package:bank_clean_flutter/models/taskItemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/clean/cleanFeedback.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CleanHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CleanHomeState();
  }
}

class _CleanHomeState extends State<CleanHome> with ComPageWidget {
  bool isLoading = false;
  bool isWork = false;
  bool isClosed = true;
  List workImages = [
    'lib/images/clean/52.jpg',
  ];
  CleanerHomeVO resData;

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      body:
//        RefreshIndicator(
//          onRefresh: _refresh,
//        child:
          LoadingPage(
        isLoading: isLoading,
//          text: "正在加载数据",
        child: resData != null
            ? Container(
                child: Column(
                  children: <Widget>[
                    /// 银行头部
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(68),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                '${resData.baseUrl + resData.orgImage}',
                                width: ScreenUtil().setWidth(52),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(12)),
                                child: Text(
                                  '${resData.orgBranchName}',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () async{
                              if (Platform.isIOS) {
                                PermissionStatus status = await PermissionHandler()
                                    .checkPermissionStatus(PermissionGroup.camera);
                                if (status.value == 1) {
                                  _scan();
                                } else {
                                  //有可能是的第一次请求
                                  _scan();
                                }
                              } else if (Platform.isAndroid) {
                                Map<PermissionGroup, PermissionStatus> permissions =
                                    await PermissionHandler().requestPermissions([
                                  PermissionGroup.camera
                                ]);
                                if (permissions[PermissionGroup.camera] !=
                                    PermissionStatus.granted) {
                                  showToast("请到设置中授予权限");
                                } else {
                                  _scan();
                                }
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:ScreenUtil().setWidth(40),
                                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                                  child: Image.asset('lib/images/clean/scan_code_icon.png'),
                                ),
                                Text('扫码',  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(28),
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /// 卡片头部
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(40),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
//                                Application.router.navigateTo(
//                                    context, Routers.cleanFeedback,
//                                    transition: TransitionType.inFromRight);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CleanFeedback(),
                                    )).then((data) {
                                  _getData();
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(7)),
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(32),
                                    ScreenUtil().setHeight(40),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(40)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      ColorUtil.color('#E94A3C'),
                                      ColorUtil.color('#CF241C'),
                                    ],
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/images/clean/clean_home_card_bg1.png'),
                                    alignment: Alignment.topRight,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'lib/images/clean/clean_card_icon1.png',
                                      width: ScreenUtil().setWidth(48),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(16),
                                          right: ScreenUtil().setWidth(12)),
                                      child: Text(
                                        '清扫反馈',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Offstage(
                                      offstage: resData.feedbackCount == 0,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenUtil().setWidth(10),
                                            ScreenUtil().setHeight(2),
                                            ScreenUtil().setWidth(10),
                                            ScreenUtil().setHeight(2)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setWidth(30))),
                                        ),
                                        child: Text(
                                          '${resData.feedbackCount}',
                                          style: TextStyle(
                                              color: ColorUtil.color('#CA2D00'),
                                              fontSize: ScreenUtil().setSp(28),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
//                                String outStr = jsonEncode(Utf8Encoder()
//                                    .convert(resData.orgBranchName));
                                Application.router.navigateTo(
                                    context,
                                    Routers.eventReport +
                                        '?outStr=${Uri.encodeComponent(resData.orgBranchName)}',
                                    transition: TransitionType.inFromRight);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(7)),
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(32),
                                    ScreenUtil().setHeight(40),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(40)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      ColorUtil.color('#EAC8A8'),
                                      ColorUtil.color('#D5A785'),
                                    ],
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/images/clean/clean_home_card_bg2.png'),
                                    alignment: Alignment.topRight,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'lib/images/clean/clean_card_icon2.png',
                                      width: ScreenUtil().setWidth(48),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(16),
                                          right: ScreenUtil().setWidth(12)),
                                      child: Text(
                                        '事件上报',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 内容
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: ListView(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
                            bottom: ScreenUtil().setHeight(80)),
                        children: <Widget>[
                          /// 今天 明天
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        resData.todayHaveWork == 1
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(48),
                                        height: ScreenUtil().setHeight(156),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  ScreenUtil().setWidth(8))),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              ColorUtil.color('#E94A3C'),
                                              ColorUtil.color('#CF241C'),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '今天',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#ffffff'),
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: resData.todayHaveWork == 1
                                              ? Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setWidth(10),
                                                            left: ScreenUtil()
                                                                .setWidth(24),
                                                            right: ScreenUtil()
                                                                .setWidth(24)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                                '${resData.todayTitle}',
                                                                style: TextStyle(
                                                                    color: ColorUtil
                                                                        .color(
                                                                            '#333333'),
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            30),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                                '${resData.todayStartWorkTime}-${resData.todayEndWorkTime}',
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              30),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        4),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        4)),
                                                        margin: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setHeight(16),
                                                            bottom: ScreenUtil()
                                                                .setHeight(29),
                                                            left: ScreenUtil()
                                                                .setWidth(32)),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              ColorUtil.color(
                                                                  '#F5F5F5'),
                                                          borderRadius: BorderRadius
                                                              .all(Radius.circular(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          28))),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _launchURL(
                                                                '${resData.longitude}',
                                                                '${resData.latitude}',
                                                                '${resData.todayAddress}');
                                                          },
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min, // 宽度自适应
                                                            children: <Widget>[
                                                              Image.asset(
                                                                'lib/images/clean/location_icon.png',
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            24),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: ScreenUtil()
                                                                        .setWidth(
                                                                            2)),
                                                                child: Text(
                                                                    '${resData.todayAddress}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorUtil
                                                                          .color(
                                                                              '#666666'),
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(28),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: ScreenUtil()
                                                            .setHeight(1),
                                                        color: ColorUtil.color(
                                                            '#EEEEEE'),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      ScreenUtil().setWidth(24),
                                                      ScreenUtil().setHeight(0),
                                                      ScreenUtil().setWidth(24),
                                                      ScreenUtil()
                                                          .setHeight(0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        '休息',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(30),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text('您辛苦了～',
                                                          style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(30),
                                                          )),
                                                    ],
                                                  ),
                                                )),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        resData.tomorrowWork == 1
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(48),
                                        height: ScreenUtil().setHeight(156),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                  ScreenUtil().setWidth(8))),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              ColorUtil.color('#ECD3BB'),
                                              ColorUtil.color('#D5A785'),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '明天',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#ffffff'),
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(

                                          /// 是否休息
                                          child: resData.tomorrowWork == 1
                                              ? Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setWidth(10),
                                                            left: ScreenUtil()
                                                                .setWidth(24),
                                                            right: ScreenUtil()
                                                                .setWidth(24)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                                '${resData.tomorrowTitle}',
                                                                style: TextStyle(
                                                                    color: ColorUtil
                                                                        .color(
                                                                            '#333333'),
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            30),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                                '${resData.tomorrowStartWorkTime}-${resData.tomorrowEndWorkTime}',
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              30),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        4),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        4)),
                                                        margin: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setHeight(16),
                                                            bottom: ScreenUtil()
                                                                .setHeight(29),
                                                            left: ScreenUtil()
                                                                .setWidth(32)),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              ColorUtil.color(
                                                                  '#F5F5F5'),
                                                          borderRadius: BorderRadius
                                                              .all(Radius.circular(
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          28))),
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _launchURL(
                                                                '${resData.longitude}',
                                                                '${resData.latitude}',
                                                                '${resData.tomorrowAddress}');
                                                          },
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min, // 宽度自适应
                                                            children: <Widget>[
                                                              Image.asset(
                                                                'lib/images/clean/location_icon.png',
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            24),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: ScreenUtil()
                                                                        .setWidth(
                                                                            2)),
                                                                child: Text(
                                                                    '${resData.tomorrowAddress}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorUtil
                                                                          .color(
                                                                              '#666666'),
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(28),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      ScreenUtil().setWidth(24),
                                                      ScreenUtil().setHeight(0),
                                                      ScreenUtil().setWidth(24),
                                                      ScreenUtil()
                                                          .setHeight(0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        '休息',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(30),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text('您辛苦了～',
                                                          style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(30),
                                                          )),
                                                    ],
                                                  ),
                                                )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// 今日任务
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(60)),
                            child: Text(
                              '今日任务',
                              style: TextStyle(
                                  color: ColorUtil.color('#000001'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          /// 今日工作item
                          Column(
                            children: _workBuild(context),
                          )
                        ],
                      ),
                    )),
//                    ListView(
//                      children: _contentList(),
//                    )
                  ],
                ),
              )
            : Text(''),
      ),
//        )
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  //扫码
  Future _scan() async {
    print('_scan_scan_scan_scan_scan');
    String cameraScanResult = await scanner.scan(); //通过扫码获取二维码中的数据
//    getScan(cameraScanResult); //将获取到的参数通过HTTP请求发送到服务器
    print(cameraScanResult); // 返回 id
    if(cameraScanResult!=null&&cameraScanResult!=""){
      Application.router.navigateTo(context, Routers.deviceInfo+'?id=${cameraScanResult}&btnType=1',
          transition: TransitionType.inFromRight);
    }

//    print(json.decode(cameraScanResult)['id']);
  }

  Future _getData() async {
    Api.getCleanerHomeData().then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
        });
        SharedPreferencesUtil.setCleanBankName(resData.orgBranchName);
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _imgList(String imagesStr) {
    List imageList = [];
    if (imagesStr != "") {
      imagesStr.split(',').forEach((val) {
        imageList.add(resData.baseUrl + val);
      });
    }
    List<Widget> images = [];
    for (int i = 0; i < imageList.length; i++) {
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
                    images: imageList, index: i, heroTag: 'simple'),
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
                imageList[i],
                width: ScreenUtil().setWidth(264),
                height: ScreenUtil().setHeight(200),
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

  void _launchURL(String longitude, String latitude, String address) async {
    String url =
        'androidamap://keywordNavi?sourceApplication=softname&keyword=' +
            address.toString() +
            '&style=2';
//    String url =
//        'androidamap://navi?sourceApplication=appname&poiname=fangheng&lat=26.57&lon=106.71&dev=1&style=2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //iOS
      String url = 'http://maps.apple.com/?ll=' +
          longitude.toString() +
          ',' +
          latitude.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  /* 拍照 */
  Future _takePhoto(int id) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 600);
    if (pickedFile != null) {
      await HttpServe.uploadFile('config/upload/image', pickedFile.path)
          .then((res) {
        print(res);
        if (res['code'] == 1) {
//          String image = res['data']['baseUrl'] + res['data']['key'];
          Map params = new Map();
          params['taskItemRecordId'] = id;
          params['image'] = res['data']['key'];
          Api.cleanerFinish(map: params).then((res) {
            _getData();
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

  void _photoClick(int index, int taskItemId) async {
    if (index == 0) {
      //请求权限
      if (Platform.isIOS) {
        PermissionStatus status = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.camera);
        if (status.value == 1) {
          _takePhoto(taskItemId);
        } else {
          //有可能是的第一次请求
          _takePhoto(taskItemId);
          showToast("请授予权限");
        }
      } else if (Platform.isAndroid) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler().requestPermissions(
                [PermissionGroup.location, PermissionGroup.camera]);
        if (permissions[PermissionGroup.camera] != PermissionStatus.granted) {
          showToast("请到设置中授予权限");
        } else {
          _takePhoto(taskItemId);
        }
      }
      return;
    }
  }

  List<Widget> _workBuild(BuildContext context) {
    List<Widget> list = [];
    List<TaskItemVO> resList = resData.taskItemVOList;
    for (int i = 0; i < resList.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(26),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(26)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorUtil.color('#EEEEEE'),
                    width: ScreenUtil().setWidth(1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(16),
                        height: ScreenUtil().setHeight(16),
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(8)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color(
                              resList[i].status == 1 ? '#CF241C' : '#AAAAAA'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(50))),
                        ),
                      ),
                      Text(
                        resList[i].status == 1 ? '待处理' : '已完成',
                        style: TextStyle(
                            color: ColorUtil.color(
                                resList[i].status == 1 ? '#CF241C' : '#AAAAAA'),
                            fontSize: ScreenUtil().setSp(28),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    '${resList[i].startTime}-${resList[i].endTime}',
                    style: TextStyle(
                      color: ColorUtil.color('#333333'),
                      fontSize: ScreenUtil().setSp(28),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(26),
                  ScreenUtil().setWidth(24),
                  ScreenUtil().setHeight(26)),
              child: Column(
                children: <Widget>[
                  /// 待处理 已完成 区分区域
                  resList[i].status == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              '${resList[i].title}',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold),
                            )),
                            GestureDetector(
                              onTap: () {
                                // _photoClick(0, resList[i].id);
                                showCustomDialog(context, '确认完成？', (){
                                  Map params = new Map();
                                  params['taskItemRecordId'] = resList[i].id;
                                  Api.cleanerFinish(map: params).then((res) {
                                    _getData();
                                    showToast(res.msg);
                                    Application.router.pop(context);
                                  });
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(40),
                                    ScreenUtil().setHeight(6),
                                    ScreenUtil().setWidth(40),
                                    ScreenUtil().setHeight(6)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorUtil.color('#CF241C'),
                                      width: ScreenUtil().setWidth(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(30))),
                                ),
                                child: Text('完成',
                                    style: TextStyle(
                                        color: ColorUtil.color('#CF241C'),
                                        fontSize: ScreenUtil().setSp(28),
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${resList[i].title}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: _imgList(resList[i].images),
                              ),
                            ],
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resList[i].open = !resList[i].open;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '清扫说明',
                            style: TextStyle(
                              color: ColorUtil.color('#999999'),
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                            child: Image.asset(
                              resList[i].open
                                  ? 'lib/images/clean/arrow_up.png'
                                  : 'lib/images/clean/arrow_down.png',
                              width: ScreenUtil().setWidth(28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !resList[i].open,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text(
                        '${resList[i].content}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }
}
