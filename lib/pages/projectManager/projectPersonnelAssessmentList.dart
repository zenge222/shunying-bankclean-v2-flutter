import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/models/userVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/eventReport.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectOutletsDetail.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectPersonnelAssessmentList extends StatefulWidget {
  final int id;

  const ProjectPersonnelAssessmentList({Key key, this.id}) : super(key: key);

  @override
  _ProjectPersonnelAssessmentListState createState() =>
      _ProjectPersonnelAssessmentListState();
}

class _ProjectPersonnelAssessmentListState
    extends State<ProjectPersonnelAssessmentList> with ComPageWidget {
  FocusNode blankNode = FocusNode();
  List<UserVO> resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<String> subTabs = ['保洁', '巡检员'];
  int subTabsIndex = 0;
  String searchName = '';
  int outId = 0; // 默认全部0
  String outStr = '全部';
  DateTime currentDate = new DateTime.now();
  String currentTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '人员考核',
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
        child: GestureDetector(
          onTap: () {
            // 点击空白页面关闭键盘
            FocusScope.of(context).requestFocus(blankNode);
          },
          child: Column(
            children: <Widget>[
              /// 搜索
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(30),
                    ScreenUtil().setHeight(16),
                    ScreenUtil().setWidth(30),
                    ScreenUtil().setHeight(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(0),
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setHeight(0)),
//                    width: ScreenUtil().setWidth(530.0),
                        height: ScreenUtil().setHeight(70.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(5))),
                          color: ColorUtil.color('#ffffff'),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(30),
                              ScreenUtil().setHeight(0),
                              ScreenUtil().setWidth(30),
                              ScreenUtil().setHeight(0)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#F8F8FA'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(36))),
                          ),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                searchName = text;
                              });
                            },
                            decoration: InputDecoration(
                              icon: Container(
                                  padding: EdgeInsets.all(0),
                                  child: Image.asset(
                                    'lib/images/clean/search_icon.png',
                                    width: ScreenUtil().setWidth(32),
                                  )),
                              contentPadding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(0),
                                  ScreenUtil().setWidth(0),
                                  ScreenUtil().setHeight(0)),
                              hintText: "输入姓名",
                              hintStyle: TextStyle(
                                  color: ColorUtil.color('#999999'),
                                  fontSize: ScreenUtil().setSp(28)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorUtil.color('#F8F8FA'),
                                    width: 0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorUtil.color('#F8F8FA'),
                                    width: 0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGetAll = false;
                            resList = [];
                            pageNum = 1;
                          });
                          _getMoreData();
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(96),
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(0),
                            bottom: ScreenUtil().setHeight(10),
                            right: ScreenUtil().setWidth(0),
                          ),
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#CF241C'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(28))),
                          ),
                          child: Text(
                            '搜索',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// tabs
              Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#F5F6F9'),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(8))),
                  ),
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(24),
                      ScreenUtil().setHeight(36),
                      ScreenUtil().setWidth(24),
                      ScreenUtil().setHeight(36)),
                  child: Row(
                    children: _items(context),
                  ),
                ),
              ),

              /// sel
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(32),
                  left: ScreenUtil().setWidth(32),
                  bottom: ScreenUtil().setHeight(16),
                  right: ScreenUtil().setWidth(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// 选择网点
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OutletsSelect(
                                type: 7,
                              ),
                            )).then((data) {
                          if (data != null) {
                            print('改变数据');
                            setState(() {
                              isGetAll = false;
                              pageNum = 1;
                              resList = [];
                              outId = data.id;
                              outStr = data.name;
                            });
                            _getMoreData();
                          }
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
                            Text(outStr==''?'选择网点':outStr,
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                            Container(
                              margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                              child: Image.asset(
                                'lib/images/sel_picker.png',
                                width: ScreenUtil().setWidth(28),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /// 选择时间
                    GestureDetector(
                      onTap: () {
                        DateTime today = DateTime.now();
                        ResetPicker.showDatePicker(context,
                            dateType: DateType.YM,
                            value: currentDate,
//                            minValue: DateTime(today.year - 5),
//                            maxValue: DateTime.now(),
//                                  DateTime(
//                                      today.year, today.month, today.day),
                            clickCallback: (var str, var time) {
                              setState(() {
                                isGetAll = false;
                                pageNum = 1;
                                resList = [];
                                currentTime = str;
                                currentDate = DateTime.parse(time);
                              });
                              _getMoreData();
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
                            Text('${currentTime}',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(28),
                                )),
                            Container(
                              margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(8)),
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
                      ScreenUtil().setHeight(0)),
                  child: _buildList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    DateTime dateTime = DateTime.now();
    setState(() {
      isLoading = true;
      isGetAll = false;
      resList = [];
      pageNum = 1;
      outId = 0;
      outStr = '全部';
      currentTime =
          '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}';
      subTabsIndex = 0;
    });
    _getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  Future _getMoreData() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['dateStr'] = currentTime;
    params['searchName'] = searchName;
    params['type'] = subTabsIndex == 0 ? 1 : 2;
    params['orgBranchId'] = outId;
    Api.getAccessUserList(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
        if (res.list.length < pageSize) {
          isGetAll = true;
        }
      }
    });
  }

  void _tabsCheck(int i) {
    setState(() {
      subTabsIndex = i;
      pageNum = 1;
      resList = [];
      isGetAll = false;
    });
    _getMoreData();
  }

  List<Widget> _items(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < subTabs.length; i++) {
      widgets.add(Expanded(
          child: GestureDetector(
        onTap: () {
          _tabsCheck(i);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              0, ScreenUtil().setHeight(12), 0, ScreenUtil().setHeight(12)),
          decoration: BoxDecoration(
            color: subTabsIndex == i
                ? ColorUtil.color('#CF241C')
                : Colors.transparent,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
          ),
          child: Text(
            subTabs[i],
            style: TextStyle(
                color: subTabsIndex == i
                    ? ColorUtil.color('#ffffff')
                    : ColorUtil.color('#CF241C'),
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(32)),
            textAlign: TextAlign.center,
          ),
        ),
      )));
    }
    return widgets;
  }

  Widget _buildList() {
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
                if (subTabsIndex == 0) {
                  Application.router.navigateTo(
                      context,
                      Routers.checkAssessmentDetail +
                          '?id=${resList[index].id}&dateStr=${currentTime}',
                      transition: TransitionType.inFromRight);
                  return;
                }
                Application.router.navigateTo(
                    context,
                    Routers.projectCheckAssessmentDetail +
                        '?id=${resList[index].id}&dateStr=${currentTime}',
                    transition: TransitionType.inFromRight);
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network(
                        '${resList[index].baseUrl + resList[index].profile}',
                        width: ScreenUtil().setWidth(152),
                        height: ScreenUtil().setHeight(152),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${resList[index].name}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                              Offstage(
                                offstage: resList[index].type == 4,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(16),
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(16)),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(10),
                                      ScreenUtil().setHeight(2),
                                      ScreenUtil().setWidth(10),
                                      ScreenUtil().setHeight(2)),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.color('#F2F2F2'),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  child: Text(
                                      '${resList[index].organizationBranchName}',
                                      style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(28),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(
                                        resList[index].type == 4 ? 16 : 0)),
                                child: Text('${resList[index].typeName}',
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(28),
                                    )),
                              ),
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
                    ))
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
