import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/equipmentReportVO.dart';
import 'package:bank_clean_flutter/models/propertyCheckRecordItemVO.dart';
import 'package:bank_clean_flutter/models/propertyCheckRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/common/repair/deviceInfo.dart';
import 'package:bank_clean_flutter/pages/common/repair/reportRepair.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryDetail extends StatefulWidget {
  final int id;

  const InventoryDetail({Key key, this.id}) : super(key: key);

  @override
  _InventoryDetailState createState() => _InventoryDetailState();
}

class _InventoryDetailState extends State<InventoryDetail> with ComPageWidget {
  bool isLoading = false;
  PropertyCheckRecordVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '资产盘点详情',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        brightness: Brightness.light,
        //默认是4， 设置成0 就是没有阴影了
        elevation: 0,
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
                      children: <Widget>[
                        /// 1
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
                          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
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
                                        Text(
                                            '${resData.organizationBranchName}',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
                                                fontWeight: FontWeight.bold)),
                                        Offstage(
                                          offstage: resData.status != 2,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(6),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(6),
                                                ScreenUtil().setHeight(0)),
                                            margin: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(14)),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.color('#CF241C'),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(ScreenUtil()
                                                      .setWidth(4))),
                                            ),
                                            child: Text('异常',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#ffffff'),
                                                  fontSize:
                                                      ScreenUtil().setSp(24),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text("${resData.createTime}",
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setWidth(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${resData.projectName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setWidth(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '检查人：${resData.managerName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                        /// 设备
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(30),
                                    ScreenUtil().setHeight(28),
                                    ScreenUtil().setWidth(30),
                                    ScreenUtil().setHeight(28)),
                                child: Text('设备',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(32),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Column(
                                children: _buildItem(resData.itemVOList),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              )
            : Text(""),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetailData();
    print(widget.id);
  }

  Future _getDetailData() async {
    Map params = new Map();
    params["id"] = widget.id;
    Api.getPropertyCheckRecordDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resData = res.data;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  _buildItem(List<PropertyCheckRecordItemVO> items) {
    List<Widget> list = [];
    items.forEach((val) {
      list.add(Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: ColorUtil.color('#EEEEEE'),
                  width: ScreenUtil().setWidth(1))),
        ),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(28),
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(28)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('编号：${val.equipmentNo}',
                    style: TextStyle(
                      color: ColorUtil.color('#333333'),
                      fontSize: ScreenUtil().setSp(28),
                    )),
                Text('    ${val.equipmentName}',
                    style: TextStyle(
                      color: ColorUtil.color('#333333'),
                      fontSize: ScreenUtil().setSp(28),
                    ))
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(32),
              child: Image.asset(val.status == 1
                  ? 'lib/images/projectManager/normal_icon.png'
                  : 'lib/images/projectManager/abnormal_icon.png'),
            )
          ],
        ),
      ));
    });
    return list;
  }
}
