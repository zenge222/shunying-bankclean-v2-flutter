import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectCheckSelect.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectOutletsDetail extends StatefulWidget {
  final int id;

  const ProjectOutletsDetail({Key key, this.id}) : super(key: key);

  @override
  _ProjectOutletsDetailState createState() => _ProjectOutletsDetailState();
}

class _ProjectOutletsDetailState extends State<ProjectOutletsDetail>
    with ComPageWidget {
  bool isLoading = false;
  OrgBranchVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点信息详情',
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
        child: resData != null
            ? Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(32),
                        right: ScreenUtil().setWidth(32),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                            ),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${resData.name}',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(40),
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.color('#333333'),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(40)),
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '地址：',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold,
                                          color: ColorUtil.color('#333333'),
                                        )),
                                    TextSpan(
                                        text: '${resData.address}',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#666666'),
                                        )),
                                  ])),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '项目：',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold,
                                          color: ColorUtil.color('#333333'),
                                        )),
                                    TextSpan(
                                        text: '${resData.projectName}',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#666666'),
                                        )),
                                  ])),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '机构：',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold,
                                          color: ColorUtil.color('#333333'),
                                        )),
                                    TextSpan(
                                        text: '${resData.organizationName}',
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(32),
                                          color: ColorUtil.color('#666666'),
                                        )),
                                  ])),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                            ),
                            padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('巡检',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtil.color('#333333'),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                          resData.allocation == 1
                                              ? '未分配巡检'
                                              : '${resData.areaManagerName}    ${resData.areaManagerPhone}',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(32),
                                            color: ColorUtil.color('#333333'),
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectCheckSelect(
                                                        id: resData.id,
                                                        type: 6,checkId:resData.areaManagerId),
                                              )).then((data) {
                                            if (data != null) {
                                              setState(() {
                                                resData.allocation = 2;
                                                resData.areaManagerName =
                                                    data.name;
                                                resData.areaManagerPhone =
                                                    data.phone;
                                                resData.areaManagerId = data.id;
                                              });
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text('请选择',
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
                                      )
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
                      child: Text('确定设置',
                          style: TextStyle(
                            color: ColorUtil.color('#ffffff'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(32),
                          )),
                      onPressed: () {
                        _submitDetail();
                      },
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
    // TODO: implement initState
    super.initState();
    _getData();
    print(widget.id);
  }

  Future _getData() async {
    Map params = new Map();
    params['orgBranchId'] = widget.id;
    Api.getAllocationDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _submitDetail() async {
    if (resData.allocation == 1) return showToast('请选择巡检');
    Map params = new Map();
    params['areaManagerId'] = resData.areaManagerId;
    params['orgBranchId'] = resData.id;
    Api.organizationBranchCommit(map: params).then((res) {
      if (res.code == 1) {
        Navigator.pop(context, 'init');
      }
      showToast(res.msg);
    });
  }
}
