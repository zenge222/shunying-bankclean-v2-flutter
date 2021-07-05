import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/equipmentScrapRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/common/repair/deviceInfo.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EquipmentScrapDetail extends StatefulWidget {
  final int id;

  const EquipmentScrapDetail({Key key, this.id}) : super(key: key);

  @override
  _EquipmentScrapDetailState createState() => _EquipmentScrapDetailState();
}

/// 区域经理 + 维修员
class _EquipmentScrapDetailState extends State<EquipmentScrapDetail>
    with ComPageWidget {
  bool isLoading = false;
  EquipmentScrapRecordVO resData;
  int submitType = 0;
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '报废申请详情',
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
                                        Text('${resData.title}',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2),
                                          ScreenUtil().setWidth(10),
                                          ScreenUtil().setHeight(2)),
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(26)),
                                      decoration: BoxDecoration(
                                        color: ColorUtil.color(
                                            resData.status == 1
                                                ? '#FFE7E6'
                                                : (resData.status == 2
                                                    ? '#FFF4EC'
                                                    : '#ECF1FF')),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Text(
                                          resData.status == 1
                                              ? '待审核'
                                              : (resData.status == 2
                                                  ? '未通过'
                                                  : '已通过'),
                                          style: TextStyle(
                                              color: ColorUtil.color(
                                                  resData.status == 1
                                                      ? '#CF241C'
                                                      : (resData.status == 2
                                                          ? '#CD8E5F'
                                                          : '#375ECC')),
                                              fontSize: ScreenUtil().setSp(28),
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${resData.projectName}-${resData.organizationBranchName}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#666666'),
                                    fontSize: ScreenUtil().setSp(28),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '报修人:${resData.repairEmployeeName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        ),
                                      ),
                                      Text('${resData.createTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(28),
                                          )),
                                    ],
                                  )),
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
                                    resData.baseUrl + resData.equipmentImg),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('${resData.equipmentName}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(32),
                                            )),
                                        Text('${resData.equipmentType}',
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
                                    child: Text('编号：NO.${resData.equipmentNo}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DeviceInfo(
                                                        id: resData
                                                            .equipmentId,btnType: 0,),
                                              )).then((data) {
                                            if (data == 'init') {
                                              setState(() {});
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(20),
                                              ScreenUtil().setHeight(5),
                                              ScreenUtil().setWidth(20),
                                              ScreenUtil().setHeight(5)),
                                          decoration: BoxDecoration(
                                            color: ColorUtil.color('#CF241C'),
                                            border: Border.all(
                                                color:
                                                    ColorUtil.color('#CF241C'),
                                                width:
                                                    ScreenUtil().setWidth(1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setWidth(30))),
                                          ),
                                          child: Text('设备信息',
                                              style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#ffffff'),
                                                  fontSize:
                                                      ScreenUtil().setSp(28),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),

                        /// 3
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
                              Text('报废申请原因',
                                  style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontSize: ScreenUtil().setSp(36),
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16)),
                                child: Text('${resData.content}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(20)),
                                child: Wrap(
                                  children: _imgList(resData.img),
                                ),
                              )
                            ],
                          ),
                        ),

                        /// 5
                        Offstage(
                          offstage: resData.status == 1,
                          child: Container(
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
                                Container(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('审批人',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    Text('${resData.checkName}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  Offstage(
                    offstage: resData.status != 1 || type == "6",
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(16),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(16)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(13)),
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(20),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(20)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(60))),
                              color: ColorUtil.color('#EAEAEA'),
                              child: Text('拒绝',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                setState(() {
                                  submitType = 2;
                                });
                                showCustomDialog(context, '确定拒绝', () {
                                  Application.router.pop(context);
                                  _submitReport();
                                });
                              },
                            ),
                          )),
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
                              child: Text('通过',
                                  style: TextStyle(
                                    color: ColorUtil.color('#ffffff'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              onPressed: () {
                                setState(() {
                                  submitType = 1;
                                });
                                showCustomDialog(context, '确定通过', () {
                                  Application.router.pop(context);
                                  _submitReport();
                                });
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
    setState(() {
      isLoading = true;
    });
    _getType();
    _getDetailData();
    print(widget.id);
  }

  _getType() async {
    String appType = await SharedPreferencesUtil.getType();
    setState(() {
      type = appType;
    });
  }

  Future _getDetailData() async {
    Map params = new Map();
    params["id"] = widget.id;
    Api.getEquipmentScrapRecordDetail(map: params).then((res) {
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

  Future _submitReport() async {
    Map params = new Map();
    params["id"] = widget.id;
    params["status"] = submitType;
    Api.equipmentScrapRecordCommit(map: params).then((res) {
      if (res.code == 1) {
        Navigator.pop(context, "init");
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _imgList(String resImage) {
    List<Widget> images = [];
    if (resImage == "") return images;
    List imgList = [];
    resImage.split(",").forEach((val) {
      imgList.add(resData.baseUrl + val);
    });
    for (int i = 0; i < imgList.length; i++) {
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
                    images: imgList, index: i, heroTag: 'simple'),
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
                imgList[i],
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
