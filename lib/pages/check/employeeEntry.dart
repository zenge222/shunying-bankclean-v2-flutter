import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/http/HttpServe.dart';
import 'package:bank_clean_flutter/models/cleanerVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EmployeeEntry extends StatefulWidget {
  final int isAdd; // 0 add 1 edit
  final int id;

  const EmployeeEntry({Key key, this.isAdd, this.id}) : super(key: key);

  @override
  _EmployeeEntryState createState() => _EmployeeEntryState();
}

class _EmployeeEntryState extends State<EmployeeEntry> with ComPageWidget {
  FocusNode blankNode = FocusNode();
  bool isLoading = false;
  String _image = '';

  CleanerVO resData;

  /// 文本索引限制界限处理
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _idCardController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '员工录入',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        brightness: Brightness.light,
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: LoadingPage(
          isLoading: isLoading,
          child: (resData != null || widget.isAdd == 0)
              ? Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          /// 姓名
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
                                ScreenUtil().setHeight(20),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('姓名',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: TextField(
                                      controller: _nameController,
                                      onChanged: (text) {
//                                        setState(() {
//                                          resData.name = text;
//                                        });
                                      },
                                      textAlign: TextAlign.right,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#333333'),
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                      decoration: InputDecoration(
                                        fillColor: ColorUtil.color('#ffffff'),
                                        filled: true,
                                        contentPadding: EdgeInsets.all(
                                          ScreenUtil().setSp(20),
                                        ),
                                        hintText: "请输入",
                                        border: InputBorder.none,
                                        //用于提示文字对齐),
                                        hasFloatingPlaceholder: false,
                                      )),
                                )
                              ],
                            ),
                          ),

                          /// 手机
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
                                ScreenUtil().setHeight(20),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('手机',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: TextField(
                                      controller: _phoneController,
                                      onChanged: (text) {
//                                        setState(() {
//                                          resData.phone = text;
//                                        });
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                        LengthLimitingTextInputFormatter(11)
                                        //限制长度
                                      ],
                                      textAlign: TextAlign.right,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#333333'),
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                      decoration: InputDecoration(
                                        fillColor: ColorUtil.color('#ffffff'),
                                        filled: true,
                                        contentPadding: EdgeInsets.all(
                                          ScreenUtil().setSp(20),
                                        ),
                                        hintText: "请输入",
                                        border: InputBorder.none,
                                        //用于提示文字对齐),
                                        hasFloatingPlaceholder: false,
                                      )),
                                )
                              ],
                            ),
                          ),

                          /// 身份证
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
                                ScreenUtil().setHeight(20),
                                ScreenUtil().setWidth(32),
                                ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('身份证',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: TextField(
                                      controller: _idCardController,
                                      onChanged: (text) {
//                                        setState(() {
//                                          resData.idCardNo = text;
//                                        });
                                      },
                                      textAlign: TextAlign.right,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#333333'),
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                      decoration: InputDecoration(
                                        fillColor: ColorUtil.color('#ffffff'),
                                        filled: true,
                                        contentPadding: EdgeInsets.all(
                                          ScreenUtil().setSp(20),
                                        ),
                                        hintText: "请输入",
                                        border: InputBorder.none,
                                        //用于提示文字对齐),
                                        hasFloatingPlaceholder: false,
                                      )),
                                )
                              ],
                            ),
                          ),

                          /// 照片
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
                                Text('照片',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50)),
                                  child: _image != ''
                                      ? GestureDetector(
                                          onTap: () {
                                            _photoClick(0);
                                          },
                                          child: Image.network(_image,
                                              width: ScreenUtil().setWidth(192),
                                              height:
                                                  ScreenUtil().setHeight(192)),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _photoClick(0);
                                          },
                                          child: Image.asset(
                                            'lib/images/clean/phone_img.png',
                                            width: ScreenUtil().setWidth(192),
                                            height: ScreenUtil().setHeight(192),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(60))),
                        color: ColorUtil.color('#CF241C'),
                        child: Text('确定',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        onPressed: () {
                          _submitReport();
                        },
                      ),
                    )
                  ],
                )
              : Text(''),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('isAdd:' + widget.isAdd.toString());
    print('id:' + widget.id.toString());
    if (widget.isAdd == 1) {
      _getData();
    } else {
      _nameController.text = '';
      _phoneController.text = '';
      _idCardController.text = '';
      CleanerVO cleanerVO = new CleanerVO();
      cleanerVO.profile = '';
      resData = cleanerVO;
    }
  }

  Future _getData() async {
    setState(() {
      isLoading = true;
    });
    Map params = new Map();
    params['id'] = widget.id;
    Api.getCleanerDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
        });
        _nameController.text = resData.name;
        _phoneController.text = resData.phone;
        _idCardController.text = resData.idCardNo;
      }
    });
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
            resData.profile = res['data']['key'];
            _image = res['data']['baseUrl'] + res['data']['key'];
          });
        } else {
          showToast(res['mag']);
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

  Future _submitReport() async {
    if (_nameController.text == '') {
      showToast('请输入姓名');
    } else if (_phoneController.text == '') {
      showToast('请输入手机号码');
    } else if (_idCardController.text == '') {
      showToast('请输入身份证号码');
    } else if (resData.profile == '') {
      showToast('请上传头像');
    } else {
      /// 添加
      if (widget.isAdd == 0) {
        Map params = new Map();
        params['idCardNo'] = _idCardController.text;
        params['name'] = _nameController.text;
        params['phone'] = _phoneController.text;
        params['profile'] = resData.profile;
        Api.userCleanerCreate(map: params).then((res) {
          if (res.code == 1) {
            Navigator.pop(context, 'init');
          }
          showToast(res.msg);
        });

        /// 修改
      } else {
        Api.submitCleanerEdit(formData: resData).then((res) {
          if (res.code == 1) {
            Navigator.pop(context, 'init');
          }
          showToast(res.msg);
        });
      }
    }
  }
}
