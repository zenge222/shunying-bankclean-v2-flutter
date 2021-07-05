import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/areaLeaderAssessVO.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectCheckAssessmentDetail extends StatefulWidget {
  final int id;
  final String dateStr;

  const ProjectCheckAssessmentDetail({Key key, this.id, this.dateStr})
      : super(key: key);

  @override
  _ProjectCheckAssessmentDetailState createState() =>
      _ProjectCheckAssessmentDetailState();
}

class _ProjectCheckAssessmentDetailState
    extends State<ProjectCheckAssessmentDetail> with ComPageWidget {
  AreaLeaderAssessVO resData;
  bool isLoading = false;
  DateTime currentDate = new DateTime.now();
  String currentTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '巡检考核详情',
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
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(0),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(40)),
                        child: Column(
                          children: <Widget>[
                            /// 头部信息
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24)),
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#ffffff'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    child: Image.network(
                                      '${resData.baseUrl+resData.profile}',
                                      width: ScreenUtil().setWidth(152),
                                      height: ScreenUtil().setHeight(152),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(20)),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(30)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('${resData.name}',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(32),
                                                )),
//                                            Container(
//                                              margin: EdgeInsets.fromLTRB(
//                                                  ScreenUtil().setWidth(0),
//                                                  ScreenUtil().setHeight(16),
//                                                  ScreenUtil().setWidth(0),
//                                                  ScreenUtil().setHeight(16)),
//                                              padding: EdgeInsets.fromLTRB(
//                                                  ScreenUtil().setWidth(10),
//                                                  ScreenUtil().setHeight(2),
//                                                  ScreenUtil().setWidth(10),
//                                                  ScreenUtil().setHeight(2)),
//                                              decoration: BoxDecoration(
//                                                color:
//                                                    ColorUtil.color('#F2F2F2'),
//                                                borderRadius: BorderRadius.all(
//                                                    Radius.circular(ScreenUtil()
//                                                        .setWidth(8))),
//                                              ),
//                                              child: Text('奉贤支行',
//                                                  style: TextStyle(
//                                                      color: ColorUtil.color(
//                                                          '#666666'),
//                                                      fontSize: ScreenUtil()
//                                                          .setSp(28),
//                                                      fontWeight:
//                                                          FontWeight.bold)),
//                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setWidth(16),),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(8),),
                                                    child: Image.asset(
                                                      'lib/images/call_phone_icon.png',
                                                      width: ScreenUtil()
                                                          .setWidth(32),
                                                    ),
                                                  ),
                                                  Text('13081014458',
                                                      style: TextStyle(
                                                        color: ColorUtil.color(
                                                            '#666666'),
                                                        fontSize: ScreenUtil()
                                                            .setSp(28),
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
//                                        RichText(
//                                            text: TextSpan(children: [
//                                          TextSpan(
//                                              text: '06:00-15:00',
//                                              style: TextStyle(
//                                                color:
//                                                    ColorUtil.color('#666666'),
//                                                fontSize:
//                                                    ScreenUtil().setSp(28),
//                                              )),
//                                        ])),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),

                            /// 选择时间
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24)),
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(28),
                                  bottom: ScreenUtil().setHeight(50)),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Column(
                                children: <Widget>[
                                  /// 事件时间
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(218),
                                        height: ScreenUtil().setHeight(2),
                                        color: ColorUtil.color('#F4F4F4'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          DateTime today = DateTime.now();
                                          ResetPicker.showDatePicker(context,
                                              value: currentDate,
                                              dateType: DateType.YM,
                                              minValue:
                                                  DateTime(today.year - 5),
                                              maxValue: DateTime.now(),
                                              clickCallback:
                                                  (var str, var time) {
                                           setState(() {
                                             currentTime = str;
                                             currentDate = DateTime.parse(time);
                                           });
                                           _getData();
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(28),
                                              ScreenUtil().setHeight(8),
                                              ScreenUtil().setWidth(28),
                                              ScreenUtil().setHeight(8)),
                                          decoration: BoxDecoration(
                                            color: ColorUtil.color('#F4F4F4'),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setWidth(22))),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '${currentTime}',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(28)),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: ScreenUtil()
                                                        .setWidth(4)),
                                                width:
                                                    ScreenUtil().setWidth(24),
                                                child: Image.asset(
                                                    'lib/images/clean/triangle_down.png'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(218),
                                        height: ScreenUtil().setHeight(2),
                                        color: ColorUtil.color('#F4F4F4'),
                                      ),
                                    ],
                                  ),

                                  /// 考核记录
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(64),
                                        left: ScreenUtil().setHeight(26)),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setHeight(20)),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.orgBranchCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '管辖网点数',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.orgCheckCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '巡检次数',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.aveScore}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '网点平均分',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        '${resData.feedbackCount}',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(32),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '反馈数',
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),

                                  /// 圆形统计
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(50)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(40)),
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: ScreenUtil()
                                                          .setWidth(220),
                                                      //大小
                                                      lineWidth: ScreenUtil()
                                                          .setWidth(16),
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      //指示线条大小
                                                      percent:
                                                      resData.satisfyingCount /
                                                          (resData.satisfyingCount+resData.general+resData.unSatisfying),
                                                      //当前进度
                                                      center: Text(""),
                                                      //圆角截断
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round,
                                                      backgroundColor:
                                                          ColorUtil.color(
                                                              '#EDEEEF'),
                                                      progressColor:
                                                          ColorUtil.color(
                                                              '#CF241C'), //进度条颜色
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        10),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        8)),
                                                        child: Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text: '${resData.satisfyingCount}/',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#CF241C'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          TextSpan(
                                                              text: '${resData.satisfyingCount+resData.general+resData.unSatisfying}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ])),
                                                      ),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text: '满意/',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#CF241C'),
                                                            )),
                                                        TextSpan(
                                                          // 不满意
                                                            text: '总数',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#333333'),
                                                            )),
                                                      ]))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setWidth(26)),
                                                child: Text('管辖网点满意度',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(40)),
                                          child: Column(
                                            children: <Widget>[
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: ScreenUtil()
                                                          .setWidth(220),
                                                      //大小
                                                      lineWidth: ScreenUtil()
                                                          .setWidth(16),
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      //指示线条大小
                                                      percent:
                                                          resData.onTime /
                                                              (resData.onTime+resData.outTime),
                                                      //当前进度
                                                      center: Text(""),
                                                      //圆角截断
                                                      circularStrokeCap:
                                                          CircularStrokeCap
                                                              .round,
                                                      backgroundColor:
                                                          ColorUtil.color(
                                                              '#EDEEEF'),
                                                      progressColor:
                                                          ColorUtil.color(
                                                              '#D5A785'), //进度条颜色
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        10),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        8)),
                                                        child: Text.rich(
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text: '${resData.onTime}/',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#CD8E5F'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          TextSpan(
                                                              text: '${resData.outTime}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              36),
                                                                  color: ColorUtil
                                                                      .color(
                                                                          '#333333'),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ])),
                                                      ),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text: '准时/',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#CD8E5F'),
                                                            )),
                                                        TextSpan(
                                                            text: '超时',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          20),
                                                              color: ColorUtil
                                                                  .color(
                                                                      '#333333'),
                                                            )),
                                                      ]))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setWidth(26)),
                                                child: Text('反馈处理准时度',
                                                    style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// 网点人员列表
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24)),
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#ffffff'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(32),
                                        ScreenUtil().setHeight(26),
                                        ScreenUtil().setWidth(32),
                                        ScreenUtil().setHeight(26)),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(278),
                                          child: Text('网点',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                              )),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(206),
                                          child: Text('月评分',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(28),
                                              )),
                                        ),
                                        Expanded(
                                            child: Text('满意度',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(28),
                                                )))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: _outBuild(resData.branchAssessRecordVOList),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                )
              : Text('')),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      currentTime = widget.dateStr;
    });
    _getData();
    print(widget.id);
    print(widget.dateStr);
  }

  Future _getData() async {
    Map params = new Map();
    params['areaLeaderId'] = widget.id;
    params['dateStr'] = currentTime;
    Api.getCheckAssessmentDetail(map: params).then((res) {
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

  List<Widget> _outBuild(List<BranchAssessRecordVO> resList) {
    List<Widget> list = [];
    for(int i=0;i<resList.length;i++){
      list.add( Container(
        padding: EdgeInsets.all(
            ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width:
                  ScreenUtil().setWidth(1),
                  color: ColorUtil.color(
                      '#e5e5e5'))),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(278),
              child: Text('${resList[i].title}',
                  style: TextStyle(
                    color: ColorUtil.color(
                        '#333333'),
                    fontSize:
                    ScreenUtil().setSp(28),
                  )),
            ),
            Container(
              width: ScreenUtil().setWidth(206),
              child: Text('${resList[i].aveScore}',
                  style: TextStyle(
                    color: ColorUtil.color(
                        '#333333'),
                    fontSize:
                    ScreenUtil().setSp(28),
                  )),
            ),
            Expanded(
                child: Text('${resList[i].subTitle}',
                    style: TextStyle(
                      color: ColorUtil.color(
                          '#333333'),
                      fontSize: ScreenUtil()
                          .setSp(28),
                    )))
          ],
        ),
      ));
    }
    return list;
  }
}
