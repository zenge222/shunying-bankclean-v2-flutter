import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/bankHomeVO.dart';
import 'package:bank_clean_flutter/models/taskItemVO.dart';
import 'package:bank_clean_flutter/models/taskVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/bank/bankOutletsSelect.dart';
import 'package:bank_clean_flutter/pages/check/checkFeedbackList.dart';
import 'package:bank_clean_flutter/pages/common/floorSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/provides/backAssessment.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class BankHome extends StatefulWidget {
  @override
  _BankHomeState createState() => _BankHomeState();
}

class _BankHomeState extends State<BankHome> with ComPageWidget {
  int outId = 0;
  BankHomeVO resData;
  bool isLoading = false;
  int taskId = 0;
  List orgBranchVOList = [];
  List taskVOList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      body:
//        RefreshIndicator(
//          onRefresh: _refresh,
//        child:
          LoadingPage(
        isLoading: isLoading,
//          text: "正在加载数据",
        child: resData != null
            ? Container(
//          margin: EdgeInsets.fromLTRB(
//              ScreenUtil().setWidth(32),
//              ScreenUtil().setHeight(0),
//              ScreenUtil().setWidth(32),
//              ScreenUtil().setHeight(0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: Column(
                        children: <Widget>[
                          /// 银行头部
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BankOutletsSelect(
                                      type: 6,
                                    ),
                                  )).then((data) {
                                if (data != null) {
                                  setState(() {
                                    outId = data.id;
                                    resData.orgBranchName = data.name;
                                  });
                                  SharedPreferencesUtil.setBankId(outId);
                                  _getData();
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(68),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(0)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    '${resData.baseUrl + resData.image}',
                                    width: ScreenUtil().setWidth(52),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(12)),
                                    child: Text(
                                      '${resData.orgBranchName}',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Image.asset(
                                    'lib/images/sel_picker.png',
                                    width: ScreenUtil().setWidth(36),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// 卡片头部
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(40),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(0)),
                            child: Row(
                              children: <Widget>[
                                /// 清扫需求
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Application.router.navigateTo(
                                          context,
                                          Routers.backCleanDemand +
                                              "?outId=${resData.orgBranchId}&outStr=${Uri.encodeComponent(resData.orgBranchName)}",
                                          transition:
                                              TransitionType.inFromRight);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(7)),
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(32),
                                          ScreenUtil().setHeight(40),
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(40)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            ColorUtil.color('#E94A3C'),
                                            ColorUtil.color('#CF241C'),
                                          ],
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'lib/images/clean/clean_home_card_bg1.png'),
                                          alignment: Alignment.topRight,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/clean/clean_card_icon1.png',
                                            width: ScreenUtil().setWidth(48),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(12)),
                                            child: Text(
                                              '清扫需求',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil().setSp(36),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Offstage(
                                            offstage: true,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(10),
                                                  ScreenUtil().setHeight(2),
                                                  ScreenUtil().setWidth(10),
                                                  ScreenUtil().setHeight(2)),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(ScreenUtil()
                                                        .setWidth(30))),
                                              ),
                                              child: Text(
                                                '22',
                                                style: TextStyle(
                                                    color: ColorUtil.color(
                                                        '#CA2D00'),
                                                    fontSize:
                                                        ScreenUtil().setSp(28),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// 排班申请
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Application.router.navigateTo(
                                          context,
                                          Routers.backSchedulingApply +
                                              "?outId=${resData.orgBranchId}&outStr=${Uri.encodeComponent(resData.orgBranchName)}",
                                          transition:
                                              TransitionType.inFromRight);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(7)),
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(32),
                                          ScreenUtil().setHeight(40),
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(40)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            ColorUtil.color('#EAC8A8'),
                                            ColorUtil.color('#D5A785'),
                                          ],
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'lib/images/bank/bank_Scheduling.png'),
                                          alignment: Alignment.topRight,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'lib/images/bank/bank_home_card_bg2.png',
                                            width: ScreenUtil().setWidth(48),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(12)),
                                            child: Text(
                                              '排班申请',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenUtil().setSp(36),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// sub cards
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(24)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// 今日保洁工作
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(12)),
                                      padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(32),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(20)),
                                            child: Text(
                                              '今日保洁工作',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(24)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(20)),
                                            child:
                                                Text.rich(TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      '${resData.taskItemRecordCount}',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(56),
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text:
                                                      '/${resData.allTaskItemRecordCount}',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(28),
                                                      color: ColorUtil.color(
                                                          '#CF241C'))),
                                            ])),
                                          ),
                                          Text(
                                            '已完成/总计',
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(24),
                                                color:
                                                    ColorUtil.color('#939CA3')),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// 清扫反馈
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // CheckFeedbackList
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CheckFeedbackList(),
                                          )).then((data) {
                                        _getData();
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(12)),
                                      padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(32),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setWidth(8))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text(
                                                  '今日清扫反馈',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(24)),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(20)),
                                                child: Text.rich(
                                                    TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          '${resData.feedbackCount}',
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(56),
                                                          color:
                                                              ColorUtil.color(
                                                                  '#626262'),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          '/${resData.allFeedbackCount}',
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(28),
                                                          color:
                                                              ColorUtil.color(
                                                                  '#CF241C'))),
                                                ])),
                                              ),
                                              Text(
                                                '已完成/总计',
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(24),
                                                    color: ColorUtil.color(
                                                        '#939CA3')),
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            'lib/images/my/right_icon.png',
                                            width: ScreenUtil().setWidth(32),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 今日保洁工作
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          bottom: ScreenUtil().setHeight(0)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(20),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(20)),
                            width: double.infinity,
                            child: Text('今日保洁工作',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(36),
                                    color: ColorUtil.color('#000000'),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(20),
                                ScreenUtil().setWidth(0),
                                ScreenUtil().setHeight(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  height: ScreenUtil().setHeight(60),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: _floorTabs(),
                                  ),
                                )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FloorSelect(id: taskId,orgId: outId,),
                                        )).then((data) {
                                      if (data != null) {
                                        setState(() {
                                          taskId = data;
                                        });
                                        _getWorkList();
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: ScreenUtil().setWidth(48),
                                    child: Image.asset(
                                        'lib/images/floor_tabs.png'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(24),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      children: _workBuild(context),
                    ))
                  ],
                ),
              )
            : Text(''),
      ),
//        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

//  Future _getListData(BuildContext context) async {
//    await Provide.value<BackAssessmentProvide>(context).initData();
//    return "加载完成";
//  }

  Future _getDataList() async {
    int orgBranchId = await SharedPreferencesUtil.getBankId();
    print('orgBranchId:' + orgBranchId.toString());
    Map params = new Map();
    params['orgBranchId'] = orgBranchId;
    params['pageNo'] = 1;
    params['pageSize'] = 9999;
    params['year'] = DateTime.now().year;
    Api.getBranchAssessRecordList(map: params).then((res) {
      if (res.code == 1) {
        Provide.value<BackAssessmentProvide>(context)
            .changeDate(DateTime.now().year);
        Provide.value<BackAssessmentProvide>(context)
            .changeCurrentDate(DateTime.now());
        Provide.value<BackAssessmentProvide>(context).changeList(res.list);
      } else {
        print(res.msg);
      }
    });
  }

  Future _getWorkList() async {
    int orgBranchId = await SharedPreferencesUtil.getBankId();
    Map params = new Map();
    params['orgId'] = orgBranchId;
    params['taskId'] = taskId==0?'':taskId;
    Api.taskIndexTaskInfo(map: params).then((res) {
      if (res.code == 1) {
        if (res.data.taskVOList.length > 0) {
          setState(() {
            taskVOList = res.data.taskVOList;
          });
          if (taskId == 0) {
            setState(() {
              taskId = taskVOList[0].id;
            });
          }
        }
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getData() async {
    if (outId != 0) {
      Map params = new Map();
      params['orgBranchId'] = outId;
      Api.getBankHomeData(map: params).then((res) {
        if (res.code == 1) {
          setState(() {
            resData = res.data;
          });
          _getDataList();
          _getWorkList();
        } else {
          showToast(res.msg);
        }
      });
    } else {
      Api.getBankHomeData().then((res) {
        if (res.code == 1) {
          setState(() {
            resData = res.data;
          });
          SharedPreferencesUtil.setBankId(res.data.orgBranchId);
          _getDataList();
          _getWorkList();
        } else {
          showToast(res.msg);
        }
      });
    }
  }

  List<Widget> _workBuild(BuildContext context) {
    List<Widget> list = [];
    if (taskVOList.length > 0) {
      List<TaskItemVO> resList = taskVOList[0].taskItemVOList;
      if (resList.length > 0) {
        for (int i = 0; i < resList.length; i++) {
          list.add(Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
            ),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(20),
                      ScreenUtil().setWidth(32),
                      ScreenUtil().setHeight(20)),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorUtil.color('#EEEEEE'),
                            width: ScreenUtil().setWidth(1))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(16),
                            height: ScreenUtil().setHeight(16),
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(6)),
                            decoration: BoxDecoration(
                              color: ColorUtil.color(resList[i].status == 1
                                  ? '#CF241C'
                                  : '#999999'),
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
                              maxWidth: ScreenUtil().setWidth(444),
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
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          child: Wrap(
                            spacing: ScreenUtil().setWidth(22),
                            //主轴上子控件的间距
                            runSpacing: ScreenUtil().setHeight(22),
                            //交叉轴上子控件之间的间距
                            children: _imgList(resList[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        }
      }
    }
    return list;
  }

  List<Widget> _imgList(TaskItemVO item) {
    List pics = [];
    if (item.images != '') {
      item.images.split(',').forEach((val) {
        pics.add(resData.baseUrl + val);
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

  List<Widget> _floorTabs() {
    List<Widget> list = [];
    if (taskVOList.length > 0) {
      for (int i = 0; i < taskVOList.length; i++) {
        list.add(GestureDetector(
          onTap: () {
            taskVOList.forEach((val) {
              val.select = false;
            });
            setState(() {
              taskVOList[i].select = true;
              taskId = taskVOList[i].id;
            });
            _getWorkList();
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(14),
                ScreenUtil().setHeight(8),
                ScreenUtil().setWidth(14),
                ScreenUtil().setHeight(0)),
            decoration: BoxDecoration(
              color: ColorUtil.color(
                  taskId == taskVOList[i].id ? '#CF241C' : '#ffffff'),
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
            ),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
            child: Text('${taskVOList[i].title}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    color: ColorUtil.color(
                        taskId == taskVOList[i].id ? '#ffffff' : '#555555'),
                    fontWeight: FontWeight.bold)),
          ),
        ));
      }
    }
    return list;
  }
}
