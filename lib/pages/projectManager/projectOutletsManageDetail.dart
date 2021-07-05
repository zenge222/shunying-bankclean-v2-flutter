import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgCheckInfoVO.dart';
import 'package:bank_clean_flutter/models/taskItemVO.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectOutletsManageDetail extends StatefulWidget {
  final int id;

  const ProjectOutletsManageDetail({Key key, this.id}) : super(key: key);

  @override
  _ProjectOutletsManageDetailState createState() =>
      _ProjectOutletsManageDetailState();
}

/// 项目经理
class _ProjectOutletsManageDetailState extends State<ProjectOutletsManageDetail>
    with ComPageWidget {
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  bool isLoading = false;
  OrgCheckInfoVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点考核详情',
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
        child: SingleChildScrollView(
          child: resData != null
              ? Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(32),
                      bottom: ScreenUtil().setWidth(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// 头部
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#ffffff'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${resData.orgBranchName}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(40),
                                    fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text('地址：',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(32),
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                      child: Text('${resData.address}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(32),
                                          )))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      /// 选择日期 group
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
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
                            /// 选择时间
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        dateType: DateType.YM,
                                        value: currentDate,
                                        minValue: DateTime(today.year - 5),
                                        maxValue: DateTime.now(),
//                                  DateTime(
//                                      today.year, today.month, today.day),
                                        clickCallback: (var str, var time) {
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
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(28)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(4)),
                                          width: ScreenUtil().setWidth(24),
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
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '${resData.aveScore}分',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#CF241C'),
                                                fontSize:
                                                    ScreenUtil().setSp(36),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '网点评分',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(22)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print(currentTime);
                                        print(
                                            "?id=${widget.id}&dateStr=${currentTime}");
                                        if (resData.aveScore != 0) {
                                          Application.router.navigateTo(
                                              context,
                                              Routers.projectAppraiseDetail +
                                                  "?id=${widget.id}&dateStr=${currentTime}",
                                              transition:
                                                  TransitionType.inFromRight);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                '${resData.subTitle}',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#CF241C'),
                                                    fontSize:
                                                        ScreenUtil().setSp(36),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '满意度',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#333333'),
                                                    fontSize:
                                                        ScreenUtil().setSp(22)),
                                              ),
                                            ],
                                          ),
                                          Offstage(
                                            offstage: resData.aveScore == 0,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(4)),
                                              width: ScreenUtil().setWidth(28),
                                              child: Image.asset(
                                                  'lib/images/projectManager/right_icon.png'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '${resData.orgCheckRecordCount}',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(32),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '巡检次数',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(22)),
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
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(32),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '反馈数',
                                            style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(22)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// 圆形统计
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                              child: CircularPercentIndicator(
                                                radius:
                                                    ScreenUtil().setWidth(220),
                                                //大小
                                                lineWidth:
                                                    ScreenUtil().setWidth(16),
                                                animation: true,
                                                animationDuration: 1000,
                                                //指示线条大小
                                                percent: resData
                                                        .finishTaskCount /
                                                    (resData.finishTaskCount +
                                                        resData
                                                            .unFinishTaskCount),
                                                //当前进度
                                                center: Text(""),
                                                //圆角截断
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                backgroundColor:
                                                    ColorUtil.color('#EDEEEF'),
                                                progressColor: ColorUtil.color(
                                                    '#CF241C'), //进度条颜色
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      ScreenUtil().setWidth(0),
                                                      ScreenUtil()
                                                          .setHeight(10),
                                                      ScreenUtil().setWidth(0),
                                                      ScreenUtil()
                                                          .setHeight(8)),
                                                  child: Text.rich(
                                                      TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            '${resData.finishTaskCount}/',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(36),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#CF241C'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text:
                                                            '${resData.unFinishTaskCount}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(36),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ])),
                                                ),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                      text: '已完成/',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: ColorUtil.color(
                                                            '#CF241C'),
                                                      )),
                                                  TextSpan(
                                                      text: '未完成',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ]))
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(26)),
                                          child: Text('保洁任务完成度',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(24),
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
                                              child: CircularPercentIndicator(
                                                radius:
                                                    ScreenUtil().setWidth(220),
                                                //大小
                                                lineWidth:
                                                    ScreenUtil().setWidth(16),
                                                animation: true,
                                                animationDuration: 1000,
                                                //指示线条大小
                                                percent: resData.onTime /
                                                    (resData.onTime +
                                                        resData.outTime),
                                                //当前进度
                                                center: Text(""),
                                                //圆角截断
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                backgroundColor:
                                                    ColorUtil.color('#EDEEEF'),
                                                progressColor: ColorUtil.color(
                                                    '#D5A785'), //进度条颜色
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      ScreenUtil().setWidth(0),
                                                      ScreenUtil()
                                                          .setHeight(10),
                                                      ScreenUtil().setWidth(0),
                                                      ScreenUtil()
                                                          .setHeight(8)),
                                                  child: Text.rich(
                                                      TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            '${resData.onTime}/',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(36),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#CD8E5F'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text:
                                                            '${resData.outTime}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(36),
                                                            color:
                                                                ColorUtil.color(
                                                                    '#333333'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ])),
                                                ),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                      text: '准时/',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: ColorUtil.color(
                                                            '#CD8E5F'),
                                                      )),
                                                  TextSpan(
                                                      text: '超时',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        color: ColorUtil.color(
                                                            '#333333'),
                                                      )),
                                                ]))
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(26)),
                                          child: Text('反馈处理准时度',
                                              style: TextStyle(
                                                color:
                                                    ColorUtil.color('#333333'),
                                                fontSize:
                                                    ScreenUtil().setSp(24),
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
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('网点人员',
                                      style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(28),
                                      )),
                                  Text('${resData.userList.length}人',
                                      style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(24),
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: _useBuild(resData.userList),
                            )
                          ],
                        ),
                      ),

                      /// 今日保洁工作
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                        child: Text('今日保洁工作',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(36),
                                color: ColorUtil.color('#000000'),
                                fontWeight: FontWeight.bold)),
                      ),
                      Column(
                        children: _cleanerWorksBuild(resData.taskItemVOList),
                      )
                    ],
                  ),
                )
              : Text(''),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTime = DateTime.now();
    setState(() {
      isLoading = true;
      currentTime =
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}';
    });
    _getData();
    print(widget.id);
  }

  Future _getData() async {
    Map params = new Map();
    params['dateStr'] = currentTime;
    params['orgBranchId'] = widget.id;
    Api.getOrganizationBranchDetail(map: params).then((res) {
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

  List<Widget> _useBuild(List<UserVO> userList) {
    List<Widget> list = [];
    for (int i = 0; i < userList.length; i++) {
      list.add(Container(
        width: double.infinity,
        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: ScreenUtil().setWidth(1),
                  color: ColorUtil.color('#e5e5e5'))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Image.network(
                  '${userList[i].baseUrl + userList[i].profile}',
                  width: ScreenUtil().setWidth(88),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text('${userList[i].name}',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(32),
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(8)),
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(10),
                                  ScreenUtil().setHeight(2),
                                  ScreenUtil().setWidth(10),
                                  ScreenUtil().setHeight(2)),
                              decoration: BoxDecoration(
                                color: ColorUtil.color('#EEEEEE'),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setWidth(8))),
                              ),
                              child: Text('${userList[i].typeName}',
                                  style: TextStyle(
                                      color: ColorUtil.color('#CF241C'),
                                      fontSize: ScreenUtil().setSp(28),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: Text('${userList[i].phone}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(24),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            )),
            Container(
              width: ScreenUtil().setWidth(132),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(0),
                    ScreenUtil().setHeight(0),
                    ScreenUtil().setWidth(0),
                    ScreenUtil().setHeight(0)),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(60)),
                  side: BorderSide(
                    color: ColorUtil.color('#CF241C'),
                    width: ScreenUtil().setWidth(1),
                  ),
                ),
                color: ColorUtil.color('#ffffff'),
                child: Text('考核详情',
                    style: TextStyle(
                      color: ColorUtil.color('#CF241C'),
                      fontSize: ScreenUtil().setSp(24),
                    )),
                onPressed: () {
                  /// 保洁
                  if (userList[i].type == 2 || userList[i].type == 3) {
                    Application.router.navigateTo(
                        context,
                        Routers.checkAssessmentDetail +
                            '?id=${userList[i].id}&dateStr=${currentTime}',
                        transition: TransitionType.inFromRight);
                  } else if (userList[i].type == 4) {
                    /// 巡检
                    Application.router.navigateTo(
                        context,
                        Routers.projectCheckAssessmentDetail +
                            '?id=${userList[i].id}&dateStr=${currentTime}',
                        transition: TransitionType.inFromRight);
                  }
                },
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> _cleanerWorksBuild(List<TaskItemVO> resList) {
    List<Widget> list = [];
    for (int i = 0; i < resList.length; i++) {
      list.add(Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
        ),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(16),
                        height: ScreenUtil().setHeight(16),
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(6)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color(
                              resList[i].status == 1 ? '#CF241C' : '#999999'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(100))),
                        ),
                      ),
                      Text('${resList[i].statusText}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                              color: ColorUtil.color(resList[i].status == 1
                                  ? '#CF241C'
                                  : '#999999'),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Text('${resList[i].startTime}-${resList[i].endTime}',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: ColorUtil.color('#333333'),
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: ScreenUtil().setWidth(360),
                        ),
                        child: Text('${resList[i].title}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(36),
                              color: ColorUtil.color('#333333'),
                            )),
                      ),
                      Text('${resList[i].cleanerName}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: ColorUtil.color('#333333'),
                          ))
                    ],
                  ),
                  Offstage(
                    offstage: resList[i].status == 1,
                    child: Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                      child: Wrap(
                        spacing: ScreenUtil().setWidth(22),
                        //主轴上子控件的间距
                        runSpacing: ScreenUtil().setHeight(22),
                        //交叉轴上子控件之间的间距
                        children: _imgList(resList[i]),
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

  List<Widget> _imgList(TaskItemVO item) {
    List pics = [];
    if (item.images != '') {
      item.images.split(',').forEach((val) {
        pics.add(item.baseUrl + val);
      });
    }
    List<Widget> images = [];
    for (int i = 0; i < pics.length; i++) {
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
                    images: pics, index: i, heroTag: 'simple'),
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
                pics[i],
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
