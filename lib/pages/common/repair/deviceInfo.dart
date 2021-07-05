import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/equipmentRepairRecordVO.dart';
import 'package:bank_clean_flutter/models/equipmentVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceInfo extends StatefulWidget {
  final int id;
  final int btnType; // 0 不显示  1 显示

  const DeviceInfo({Key key, this.id, this.btnType}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

/// 保洁 区域经理 维修工
class _DeviceInfoState extends State<DeviceInfo> with ComPageWidget {
  bool isLoading = false;
  List _images = [];
  String type = ''; //  1 保洁 2 领班 3 主管 4 银行人员 5 区域经理 6 维修工
  EquipmentVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '设备信息',
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(152),
                                height: ScreenUtil().setHeight(152),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(8))),
                                  border: Border.all(
                                      width: ScreenUtil().setWidth(2),
                                      color: ColorUtil.color('#EEEEEE')),
                                ),
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20)),
                                child: Image.network(
                                    resData.baseUrl + resData.img),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('${resData.name}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(32),
                                            )),
                                        Text('${resData.typeText}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#666666'),
                                              fontSize: ScreenUtil().setSp(28),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(10),
                                        ScreenUtil().setHeight(2),
                                        ScreenUtil().setWidth(10),
                                        ScreenUtil().setHeight(2)),
                                    decoration: BoxDecoration(
                                      color: ColorUtil.color('#f2f2f2'),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setWidth(8))),
                                    ),
                                    child: Text('编号：NO.${resData.no}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(15)),
                                    child: Text(
                                        '${resData.projectName}-${resData.organizationBranchName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        )),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),

                        /// 2
                        Container(
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
                                child: Text('设备报修',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Offstage(
                                        offstage: type == "1",
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(8)),
                                          child: Text(
                                            '规格/型号：${resData.sku}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#666666'),
                                              fontSize: ScreenUtil().setSp(28),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(8)),
                                        child: Text(
                                          '购买日期：${resData.buyDate}',
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
                                          '质保期：${resData.qualityDate}',
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
                                          '检修周期：${resData.checkCycle}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(28),
                                          ),
                                        ),
                                      ),
                                      Offstage(
                                        offstage: type == "1",
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(8)),
                                          child: Text(
                                            '责任人：${resData.dutyPerson}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#666666'),
                                              fontSize: ScreenUtil().setSp(28),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),

                        /// 3
                        Container(
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
                                child: Text('厂商信息',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(8)),
                                        child: Text(
                                          '厂商：${resData.businessName}',
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
                                          '联系方式：${resData.businessContactPhone}',
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

                        /// 4
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
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(32),
                                    ScreenUtil().setHeight(24),
                                    ScreenUtil().setWidth(32),
                                    ScreenUtil().setHeight(24)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('维修记录',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(32),
                                            fontWeight: FontWeight.bold)),
                                    Text('${resData.recordVOList.length}条',
                                        style: TextStyle(
                                          color: ColorUtil.color('#CF241C'),
                                          fontSize: ScreenUtil().setSp(28),
                                        )),
                                  ],
                                ),
                              ),
                              Column(
                                children: _recordList(resData.recordVOList),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: type != '1' && type != '2' && type != '3' ||
                        widget.btnType == 0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(60),
                          ScreenUtil().setHeight(16),
                          ScreenUtil().setWidth(60),
                          ScreenUtil().setHeight(16)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(13)),
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
                              child: Text('设备报修',
                                  style: TextStyle(
                                    color: ColorUtil.color('#ffffff'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                Application.router.navigateTo(
                                    context,
                                    Routers.equipmentRepair +
                                        '?id=${widget.id}',
                                    transition: TransitionType.inFromRight);
                              },
                            ),
                          )),
                        ],
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
    // TODO: implement initState
    super.initState();
    _getType();
    setState(() {
      isLoading = true;
    });
    print(widget.id);
    _getData();
  }

  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  Future _getData() async {
    Map params = new Map();
    params["id"] = widget.id;
    Api.getEquipmentDetail(map: params).then((res) {
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

  List<Widget> _imgList(String imgStr) {
    List<Widget> images = [];
    List imageList = [];
    imgStr.split(',').forEach((val) {
      imageList.add(resData.baseUrl + val);
    });
//    print(imageList);
    if (imageList.length > 0) {
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
    }

    return images;
  }

  List<Widget> _recordList(List<EquipmentRepairRecordVO> buildList) {
    List<Widget> list = [];
    for (int i = 0; i < buildList.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          setState(() {
            buildList[i].open = !buildList[i].open;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: ColorUtil.color('#EEEEEE'),
                        width: ScreenUtil().setWidth(1))),
              ),
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${buildList[i].createTime}',
                      style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: <Widget>[
                      Text('维修员：${buildList[i].repairEmployeeName}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                      Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        width: ScreenUtil().setWidth(28),
                        child: Image.asset(
                          buildList[i].open
                              ? 'lib/images/sel_up_icon.png'
                              : 'lib/images/sel_down_icon.png',
                          width: ScreenUtil().setWidth(28),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !buildList[i].open,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(20),
                    ScreenUtil().setWidth(32),
                    ScreenUtil().setHeight(20)),
                color: ColorUtil.color('#F1F1F1'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${buildList[i].content}',
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                        )),
                    Wrap(
                      children: _imgList(buildList[i].img),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    }
    return list;
  }
}
