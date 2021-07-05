import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/equipmentMaintainRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckMachineDetail extends StatefulWidget {
  final int id;

  const CheckMachineDetail({Key key, this.id}) : super(key: key);

  @override
  _CheckMachineDetailState createState() => _CheckMachineDetailState();
}

/// 领班
class _CheckMachineDetailState extends State<CheckMachineDetail>
    with ComPageWidget {
  bool isLoading = false;
  EquipmentMaintainRecordVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '机器保养检查详情',
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
        child: resData!=null?Column(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${resData.organizationBranchName}',
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
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(8)),
                                  child: Text(
                                    '${resData.projectName}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(28),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(8)),
                                  child: Text(
                                    '检查人：${resData.checkEmployeeName}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(28),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  /// 2
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
                    padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(20)),
                          child: Text('检查情况',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(8)),
                          child: Text(
                            '${resData.content}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

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
    // TODO: implement initState
    super.initState();
    _getDetailData();
    print(widget.id);
  }


  Future _getDetailData() async {
    Map params = new Map();
    params["id"] = widget.id;
    Api.getEquipmentMaintainRecordDetail(map: params).then((res) {
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

}
