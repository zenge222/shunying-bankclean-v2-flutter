import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/bank/backAppraiseDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/backAssessment.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class BankEvaluation extends StatefulWidget {
  @override
  _BankEvaluationState createState() => _BankEvaluationState();
}

class _BankEvaluationState extends State<BankEvaluation> with ComPageWidget {
//  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();

//  int pageNum = 1;
//  int pageSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
        resizeToAvoidBottomPadding: false,
        backgroundColor: ColorUtil.color('#F5F6F9'),
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
          title: Text(
            '考评',
            style: TextStyle(color: ColorUtil.color('#333333')),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text("月度考评",
                  style: TextStyle(
                    color: ColorUtil.color('#333333'),
                    fontSize: ScreenUtil().setSp(32),
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BackAppraiseDetail(type: 0),
                    )).then((data) {
                  if (data == 'init') {
                    print('刷新list');
                    _getDataList();
                  }
                });
              },
            ),
          ],
          brightness: Brightness.light,
          // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
          elevation: 0,
          //默认是4， 设置成0 就是没有阴影了
          backgroundColor: Colors.white,
        ),
        body: Provide<BackAssessmentProvide>(builder: (context, child, data) {
          return LoadingPage(
              isLoading: isLoading,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(24),
                        ScreenUtil().setHeight(36),
                        ScreenUtil().setWidth(24),
                        ScreenUtil().setHeight(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            ResetPicker.showDatePicker(context,
                                value: data.currentDate,
                                dateType: DateType.kY,
//                            minValue: DateTime(today.year - 1),
//                            maxValue: DateTime(today.year + 1,today.month,today.day),
                                title: '选择日期',
                                clickCallback: (timeStr, time) async {
                              Provide.value<BackAssessmentProvide>(context)
                                  .changeDate(int.parse(timeStr));
                              Provide.value<BackAssessmentProvide>(context)
                                  .changeCurrentDate(DateTime.parse(time));
                              _getDataList();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(24),
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setWidth(12),
                                ScreenUtil().setHeight(10)),
                            decoration: BoxDecoration(
                              color: ColorUtil.color('#ffffff'),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(26))),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text('年份：${data.dateInt}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#333333'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(28),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(8)),
                                  child: Image.asset(
                                    'lib/images/sel_picker.png',
                                    width: ScreenUtil().setWidth(28),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(40)),
                          child: _buildList(data)))
                ],
              ));
        }));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isGetAll = true;
    });
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent) {
////        _getListData(context);
//      }
//    });
//    _getDataList();
  }

//  Future _initListData(BuildContext context) async {
//    await Provide.value<BackAssessmentProvide>(context).initData();
//    return "加载完成";
//  }
//  Future _getListData(BuildContext context) async {
//    await Provide.value<BackAssessmentProvide>(context).getListData();
//    return "加载完成";
//  }

//  Future _getDataList()async{
//    int orgBranchId = await SharedPreferencesUtil.getBankId();
//    print('orgBranchId:'+orgBranchId.toString());
//    Map params = new Map();
//    params['orgBranchId'] = orgBranchId;
//    params['pageNo'] = pageNum;
//    params['pageSize'] = pageSize;
//    Api.getBranchAssessRecordList(map: params).then((res) {
//      if (res.code == 1) {
//        pageNum++;
//        setState(() {
//          isLoading = false;
//          resList.add(res.list);
//        });
//        Provide.value<BackAssessmentProvide>(context)
//            .changeList(res.list);
//        if (res.list.length < pageSize) {
//          isGetAll = true;
//        }
//      } else {
//        showToast(res.msg);
//      }
//    });
//  }

  Future _getDataList() async {
    int orgBranchId = await SharedPreferencesUtil.getBankId();
    int date = Provide.value<BackAssessmentProvide>(context).dateInt;
    print('orgBranchId:' + orgBranchId.toString());
    Map params = new Map();
    params['orgBranchId'] = orgBranchId;
    params['pageNo'] = 1;
    params['pageSize'] = 9999;
    params['year'] = date;
    Api.getBranchAssessRecordList(map: params).then((res) {
      if (res.code == 1) {
        Provide.value<BackAssessmentProvide>(context).changeList(res.list);
      } else {
        print(res.msg);
      }
    });
  }

  Widget _buildList(data) {
    List<BranchAssessRecordVO> resList = data.examineList;
    if (resList.length != 0) {
      return ListView.builder(
        //+1 for progressbar
        itemCount: resList.length + 1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == resList.length) {
            return dataMoreLoading(isGetAll);
          } else {
            return GestureDetector(
              onTap: () {
                // ?outletsId=0&outletsStr=''"
                Application.router.navigateTo(
                    context, Routers.backAppraiseDetail + '?type=1&id=${resList[index].id}',
                    transition: TransitionType.inFromRight);
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(36)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text('${resList[index].title}',
                              style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(36),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                          ),
                          child: Text(
                              '网点：${resList[index].organizationBranchName}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(8),
                          ),
                          child: Text('考核时间：${resList[index].createTime}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        )
                      ],
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${resList[index].aveScore}',
                          style: TextStyle(
                              color: ColorUtil.color('#CF241C'),
                              fontSize: ScreenUtil().setSp(40),
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '分',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontSize: ScreenUtil().setSp(24),
                          )),
                    ])),
                  ],
                ),
              ),
            );
          }
        },
      );
    } else {
      return Center(
        child: Image.asset(
          'lib/images/default_no_list.png',
          width: ScreenUtil().setWidth(560),
        ),
      );
    }
  }
}
