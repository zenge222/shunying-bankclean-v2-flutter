import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/http/HttpServe.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/cleanSelect.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckCleanDemand extends StatefulWidget {
  @override
  _CheckCleanDemandState createState() => _CheckCleanDemandState();
}

class _CheckCleanDemandState extends State<CheckCleanDemand>
    with ComPageWidget {
  FocusNode blankNode = FocusNode();
  bool isLoading = false;
  List _images = [];
  List _images2 = [];
  String content = '';
  String outStr = '';
  int outId = 0;
  String cleanerStr = '';
  int cleanerId = 0;
  bool _isDisabled = true;
  /// 巡检
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '清扫需求发布',
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
        child: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  // 点击空白页面关闭键盘
                  FocusScope.of(context).requestFocus(blankNode);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24)),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(8)),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
//                                    Application.router.navigateTo(
//                                        context, Routers.outletsSelect,
//                                        transition: TransitionType.inFromRight);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OutletsSelect(type: 4),
                                          )).then((data) {
                                        if (data != null) {
                                          print('改变数据');
                                          setState(() {
                                            outId = data.id;
                                            outStr = data.name;
                                            cleanerId = 0;
                                            cleanerStr ='';
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                                '网点',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(36),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(
                                          children: <Widget>[
                                            Text('${outStr == '' ? '请选择' : outStr}',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                )),
                                            Container(
                                              width: ScreenUtil().setWidth(32),
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              child: Image.asset(
                                                  'lib/images/clean/sel_right.png'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(0),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(24)),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(8)),
                            ),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      if (outStr == "") {
                                        showToast('请选择网点');
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CleanSelect(
                                                id: outId,
                                                type: 7,
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
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                                '保洁员',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(36),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(
                                          children: <Widget>[
                                            Text('${cleanerStr == '' ? '请选择' : cleanerStr}',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#666666'),
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                )),
                                            Container(
                                              width: ScreenUtil().setWidth(32),
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              child: Image.asset(
                                                  'lib/images/clean/sel_right.png'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
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
                                Text('清扫信息',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50)),
                                  child: Wrap(
                                      spacing: ScreenUtil().setWidth(22),
                                      //主轴上子控件的间距
                                      runSpacing: ScreenUtil().setHeight(22),
                                      //交叉轴上子控件之间的间距
                                      children: _buildImages(context)),
                                ),
                                Material(
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(56)),
                                    child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            content = text;
                                          });
                                        },
                                        maxLines: 5,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(
                                            fontSize: 14,
                                            textBaseline:
                                                TextBaseline.alphabetic),
                                        decoration: InputDecoration(
                                          fillColor: ColorUtil.color('#F5F6F9'),
                                          filled: true,
                                          contentPadding: EdgeInsets.all(
                                            ScreenUtil().setSp(20),
                                          ),
                                          hintText: "请描述具体信息",
                                          border: InputBorder.none,
                                          hasFloatingPlaceholder: false,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                child: Text('提交',
                    style: TextStyle(
                      color: ColorUtil.color('#ffffff'),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                    )),
                disabledColor: ColorUtil.color('#E1E1E1'),

                /// _isDisabled
                onPressed: outStr == '' ||
                        cleanerStr == '' ||
                        content == '' ||
                        _images.length == 0
                    ? null
                    : () {
                        _submitDemand();
                      },
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> _buildImages(BuildContext context) {
    List<Widget> widgets = [];
    _images.forEach((val) {});
    for (int i = 0; i < _images.length; i++) {
      widgets.add(Stack(
        alignment: AlignmentDirectional.topEnd,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(22),
                right: ScreenUtil().setHeight(22)),
            child: Image.network(
              _images[i],
              width: ScreenUtil().setWidth(170),
              height: ScreenUtil().setHeight(170),
            ),
          ),
          Positioned(
              right: ScreenUtil().setWidth(0),
              top: ScreenUtil().setHeight(0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showCustomDialog(context, '确定删除', () {
                    setState(() {
                      _images.remove(_images[i]);
                      _images2.remove(_images2[i]);
                    });
                    Application.router.pop(context);
                  });
                },
                child: Container(
                  width: ScreenUtil().setWidth(44),
                  height: ScreenUtil().setHeight(44),
                  child: Image.asset(
                    'lib/images/del_imge_icon.png',
                  ),
                ),
              ))
        ],
      ));
    }
    widgets.add(GestureDetector(
      onTap: () {
        _photoClick(0);
      },
      child: Image.asset(
        'lib/images/clean/phone_img.png',
        width: ScreenUtil().setWidth(192),
        height: ScreenUtil().setHeight(192),
      ),
    ));
    return widgets;
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
          setState(() {
            _images.add(res['data']['baseUrl'] +res['data']['key']);
            _images2.add(res['data']['key']);
          });
        } else {
          showToast(res['msg']);
        }
      });
    } else {
      showToast('上传失败，请重新上传');
    }
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

  Future _submitDemand() async {
    setState(() {
      isLoading = true;
    });
    print(outId);
    print(cleanerId);
    Map params = new Map();
    params['orgBranchId'] = outId;
    params['cleanerId'] = cleanerId;
    params['content'] = content;
    params['image'] = _images2.join(',');
    Api.submitFeedbackCreate(map: params).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      }
      showToast(res.msg);
      setState(() {
        isLoading = false;
      });
    });
//
  }
}
