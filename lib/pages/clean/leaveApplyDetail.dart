import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/workOffApplyVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LeaveApplyDetail extends StatefulWidget {
  final int id;

  const LeaveApplyDetail({Key key, this.id}) : super(key: key);

  @override
  _LeaveApplyDetailState createState() => _LeaveApplyDetailState();
}

class _LeaveApplyDetailState extends State<LeaveApplyDetail> with ComPageWidget {
  bool isLoading = false;
  int detailType;
  WorkOffApplyVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '请假申请详情',
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
        child: resData!=null?Column(
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
                          child:   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('${resData.title}',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(22)),
                                    decoration: BoxDecoration(
                                      color: ColorUtil.color(resData.status == 1
                                          ? '#FFF4EC'
                                          : (resData.status == 2
                                          ? '#ECF1FF'
                                          : '#F2F2F2')),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(ScreenUtil().setWidth(8))),
                                    ),
                                    child: Text(resData.status == 1
                                        ? '待审核'
                                        : (resData.status == 2
                                        ? '已通过'
                                        : '未通过'),   style: TextStyle(
                                      color: ColorUtil.color(resData.status == 1
                                          ? '#CD8E5F'
                                          : (resData.status == 2
                                          ? '#375ECC'
                                          : '#666666')),
                                      fontSize: ScreenUtil().setSp(28),
                                    )),
                                  )
                                ],
                              ),
                              Text('${resData.createTime}',   style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '申请人：',
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
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '所在网点：',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(32),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '所在网点',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                          ])),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '请假类型：',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(32),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${resData.typeText}',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                          ])),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '请假时间：',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(32),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '${resData.startDate + resData.startTimeText + ' - ' + resData.endDate + resData.endTimeText}',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                          ])),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '请假原因：',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(32),
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '${resData.reason}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                              ])),
                        ),
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
                        Text('审批',
                            style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontSize: ScreenUtil().setSp(36),
                                fontWeight: FontWeight.bold)),
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${resData.areaManagerName}',
                                  style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                     )),
                              Container(
                                margin: EdgeInsets.only(left: ScreenUtil().setWidth(22)),
                                decoration: BoxDecoration(
                                  color: ColorUtil.color(resData.status == 1
                                      ? '#FFF4EC'
                                      : (resData.status == 2
                                      ? '#ECF1FF'
                                      : '#F2F2F2')),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().setWidth(8))),
                                ),
                                child: Text(resData.status == 1
                                    ? '待审核'
                                    : (resData.status == 2
                                    ? '已通过'
                                    : '未通过'),   style: TextStyle(
                                  color: ColorUtil.color(resData.status == 1
                                      ? '#CD8E5F'
                                      : (resData.status == 2
                                      ? '#375ECC'
                                      : '#666666')),
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: resData.status!=2,
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
                          Text('代班安排',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('代班人',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                                Text('${resData.insteadCleanerName}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ):Text(''),
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

  Future _getData()async{
    Map params = new Map();
    params['id'] = widget.id;
    Api.getLeaveApplyDetail(map:params).then((res){
      print(res.code);
      if(res.code==1){
        setState(() {
          resData = res.data;
        });
      }else{
        showToast(res.msg);
      }
    });
  }

}
