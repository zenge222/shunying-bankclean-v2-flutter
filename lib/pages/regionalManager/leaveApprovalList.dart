import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/index.dart';
import 'package:bank_clean_flutter/models/leaveTypeVo.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkleaveApplyDetail.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class LeaveApprovalList extends StatefulWidget {
  @override
  _LeaveApprovalListState createState() => _LeaveApprovalListState();
}

/// 区域经理
class _LeaveApprovalListState extends State<LeaveApprovalList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List<String> subTabs = ['待审批', '已通过', '未通过'];
  int subTabsIndex = 0;
  List<ItemVO> dateList = [];
  int dateIndex = 0;
  String dateStr = '全部';
  List<ItemVO> typeList = [];
  int typeIndex = 0;
  String typeStr = '全部';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '请假审批',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                  children: _tabItem(context),
                ),
              ),
            ),

            /// 选择
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
                      List list = [];
                      typeList.forEach((val) {
                        list.add(val.value);
                      });
                      ResetPicker.showStringPicker(context,
                          data: list,
                          normalIndex: typeIndex,
                          title: "请选择时间", clickCallBack: (int index, var str) {
                        setState(() {
                          pageNum = 1;
                          isGetAll = false;
                          resList = [];
                          typeStr = str;
                          typeIndex = index;
                        });
                        _getMaterialApplyList();
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
                          Text('请假类型：${typeStr}',
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
                  GestureDetector(
                    onTap: () {
                      List list = [];
                      dateList.forEach((val) {
                        list.add(val.value);
                      });
                      ResetPicker.showStringPicker(context,
                          data: list,
                          normalIndex: dateIndex,
                          title: "请选择时间", clickCallBack: (int index, var str) {
                        setState(() {
                          pageNum = 1;
                          isGetAll = false;
                          resList = [];
                          dateStr = str;
                          dateIndex = index;
                        });
                        _getMaterialApplyList();
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
                          Text('时间：${dateStr}',
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
//              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(0),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(0)),
              child: _buildList(),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      subTabsIndex = 0;
      isLoading = true;
      isGetAll = false;
      resList = [];
    });

    _getDateList();
    _getLeaveTypeList();
    _getMaterialApplyList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaterialApplyList();
      }
    });
  }

  Future _getMaterialApplyList() async {
    /// 如无更多数据
    if (isGetAll) return;
    int duringDate = 0;
    dateList.forEach((val) {
      if (val.value == typeStr) {
        duringDate = val.key;
        return;
      }
    });
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['duringDate'] = duringDate;
    params['status'] = subTabsIndex + 1;
    params['type'] = typeIndex;
    Api.getLeaveApplyList(map: params).then((res) {
      if (res.code == 1) {
        pageNum++;
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
        if (res.list.length < pageSize) {
          isGetAll = true;
        }
      } else {
        showToast(res.msg);
      }
    });
  }

  Future _getDateList() async {
    Api.getDateList().then((res) {
      if (res.code == 1) {
        setState(() {
          dateList = res.list;
          dateIndex = 0;
          dateStr = '全部';
        });
      }
    });
  }

  Future _getLeaveTypeList() async {
    Api.getWorkOffApplyTypeList().then((res) {
      if (res.code == 1) {
        setState(() {
          typeList = res.list;
          typeIndex = 0;
          typeStr = '全部';
        });
      }
    });
  }

  List<Widget> _tabItem(BuildContext context) {
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

  void _tabsCheck(int i) {
    setState(() {
      subTabsIndex = i;
      pageNum = 1;
      resList = [];
      isGetAll = false;
    });
    _getMaterialApplyList();
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckLeaveApplyDetail(
                        id: resList[index].id,
                      ),
                    )).then((data) {
                  if (data == 'init') {
                    print('刷新list');
                    setState(() {
                      pageNum = 1;
                      resList = [];
                      isGetAll = false;
                    });
                    _getMaterialApplyList();
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${resList[index].title}',
                            style: TextStyle(
                                color: ColorUtil.color('#333333'),
                                fontSize: ScreenUtil().setSp(36),
                                fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(subTabsIndex == 0
                                ? '#FFF4EC'
                                : (subTabsIndex == 1 ? '#ECF1FF' : '#F2F2F2')),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text(
                              '${resList[index].statusText}',
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0
                                      ? '#CD8E5F'
                                      : (subTabsIndex == 1
                                          ? '#375ECC'
                                          : '#666666')),
                                  fontSize: ScreenUtil().setSp(28),
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text('申请人：${resList[index].cleanerName}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${resList[index].organizationBranchName}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                          Text('${resList[index].createTime}',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ],
                      ),
                    )
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
