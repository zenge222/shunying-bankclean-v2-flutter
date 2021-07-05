import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/index.dart';
import 'package:bank_clean_flutter/models/repairHomeVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/repair/repairDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepairHome extends StatefulWidget {
  @override
  _RepairHomeState createState() => _RepairHomeState();
}

class _RepairHomeState extends State<RepairHome> with ComPageWidget {
  bool isLoading = false;
  bool isGetAll = false;
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<String> subTabs = ['待维修', '已维修'];
  int subTabsIndex = 0; // 1：待处理，2：待维修，3：已维修
  RepairHomeVO resData;
  List<ProjectVO> projectList = [];
  List<OrgBranchVO> branchList = [];
  int selBranchId = 0;
  int orgBranchId = 0;
  List resList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: ColorUtil.color('#F5F6F9'),
        body: LoadingPage(
            isLoading: isLoading,
            child: RefreshIndicator(
                color: ColorUtil.color('#CF241C'),
                onRefresh: () async {
                  setState(() {
                    pageNum = 1;
                    resList = [];
                    isGetAll = false;
                  });
                  _getHomeData();
                  _getDataList();
                },
                child: Stack(
                  children: <Widget>[
                    /// 背景头部
                    ListView(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Image.asset("lib/images/check/check_home_bg.png"),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(56),
                              left: ScreenUtil().setWidth(32)),
                          child: Text('维修部',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorUtil.color('#ffffff'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(36)),
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(64),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),

                          /// 报修统计
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(28)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                          height: ScreenUtil().setHeight(2),
                                          color: ColorUtil.color('#F4F4F4'),
                                        )),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(64),
                                          ScreenUtil().setHeight(0),
                                          ScreenUtil().setWidth(64),
                                          ScreenUtil().setHeight(0)),
                                      child: Text('报修统计',
                                          style: TextStyle(
                                              color: ColorUtil.color('#333333'),
                                              fontSize: ScreenUtil().setSp(32),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                        child: Container(
                                          height: ScreenUtil().setHeight(2),
                                          color: ColorUtil.color('#F4F4F4'),
                                        ))
                                  ],
                                ),
                              ),
                              resData != null
                                  ? Container(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(48)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: ScreenUtil()
                                                      .setHeight(24)),
                                              child: Text(
                                                  '${resData.todayCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            Text('今日报修',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                  ScreenUtil().setSp(28),
                                                ))
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: ScreenUtil()
                                                      .setHeight(24)),
                                              child: Text(
                                                  '${resData.needCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            Text('待维修',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                  ScreenUtil().setSp(28),
                                                ))
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: ScreenUtil()
                                                      .setHeight(24)),
                                              child: Text(
                                                  '${resData.repairedCount}',
                                                  style: TextStyle(
                                                      color: ColorUtil.color(
                                                          '#333333'),
                                                      fontSize: ScreenUtil()
                                                          .setSp(48),
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            Text('已维修',
                                                style: TextStyle(
                                                  color: ColorUtil.color(
                                                      '#333333'),
                                                  fontSize:
                                                  ScreenUtil().setSp(28),
                                                ))
                                          ],
                                        )),
                                  ],
                                ),
                              )
                                  : Text('')
                            ],
                          ),
                        ),
                        /// tabs
                        Container(
                          color: Colors.white,
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(44),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorUtil.color('#F5F6F9'),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
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
                            bottom: ScreenUtil().setHeight(0),
                            right: ScreenUtil().setWidth(32),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              /// 设备位置
                              GestureDetector(
                                onTap: () {
                                  /// 添加禁止点击空白+滑动关闭
                                  showModalBottomSheet(
                                      context: context,
                                      // 滚动控制   默认false
                                      isScrollControlled: false,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (stateContext, setState) {
                                              return GestureDetector(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  alignment: Alignment.bottomCenter,
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxHeight: ScreenUtil()
                                                            .setHeight(700),
                                                        minHeight: ScreenUtil()
                                                            .setHeight(600)),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                        2),
                                                                    color: ColorUtil
                                                                        .color(
                                                                        '#eeeeee'))),
                                                          ),
                                                          padding: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setHeight(16),
                                                            left: ScreenUtil()
                                                                .setWidth(32),
                                                            bottom: ScreenUtil()
                                                                .setHeight(16),
                                                            right: ScreenUtil()
                                                                .setWidth(32),
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                  child: Text('')),
                                                              Text(
                                                                '设备位置',
                                                                style: TextStyle(
                                                                    fontSize: 18),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Application.router
                                                                          .pop(context);
                                                                    },
                                                                    child: Text(
                                                                      '取消',
                                                                      textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(
                                                                              32),
                                                                          color: ColorUtil
                                                                              .color(
                                                                              '#CF241C')),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  color:
                                                                  ColorUtil.color(
                                                                      '#F5F6F9'),
                                                                  width: ScreenUtil()
                                                                      .setWidth(240),
                                                                  child: ListView(
                                                                    // physics: NeverScrollableScrollPhysics(),
                                                                    children:
                                                                    _projectBuild(
                                                                        context,
                                                                        setState),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child: ListView(
                                                                      // physics: NeverScrollableScrollPhysics(),
                                                                      children:
                                                                      _branchBuild(
                                                                          context,
                                                                          setState),
                                                                    )),
                                                              ],
                                                            )),
                                                        Container(
                                                          width: double.infinity,
                                                          color: Colors.white,
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                              ScreenUtil()
                                                                  .setWidth(80),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                  16),
                                                              ScreenUtil()
                                                                  .setWidth(80),
                                                              ScreenUtil()
                                                                  .setHeight(
                                                                  16)),
                                                          child: FlatButton(
                                                            padding:
                                                            EdgeInsets.fromLTRB(
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                    0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                    20),
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                    0),
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                    20)),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                        60))),
                                                            color: ColorUtil.color(
                                                                '#CF241C'),
                                                            child: Text('确定',
                                                                style: TextStyle(
                                                                  color: ColorUtil
                                                                      .color(
                                                                      '#ffffff'),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                      32),
                                                                )),
                                                            onPressed: () async {
                                                              setState(() {
                                                                isLoading = true;
                                                                isGetAll = false;
                                                                orgBranchId =
                                                                    selBranchId;
                                                                pageNum = 1;
                                                                resList = [];
                                                              });
                                                              _getDataList();
                                                              Application.router
                                                                  .pop(context);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // 禁止下滑关闭 注释代码开启
                                                onVerticalDragUpdate: (e) => false,
                                              );
                                            });
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
                                        Radius.circular(
                                            ScreenUtil().setWidth(26))),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text('设备位置',
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
                              ScreenUtil().setHeight(24),
                              ScreenUtil().setWidth(32),
                              ScreenUtil().setHeight(0)),
                          child: _buildList(),
                        )),
                      ],
                    ),
                  ],
                ))));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      isGetAll = false;
    });
    _getHomeData();
    _getProjectList();
    _getDataList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getDataList();
      }
    });
  }

  /// 首页数据
  Future _getHomeData() async {
    Api.getRepairHomeData().then((res) {
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

  /// 首页报修列表
  Future _getDataList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['orgBranchId'] = orgBranchId;
    params['status'] = subTabsIndex == 0 ? 2 : 3;
    Api.getEquipmentReportList(map: params).then((res) {
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

  /// 设备位置 项目列表
  Future _getProjectList() async {
    Api.getProjectAll().then((res) {
      if (res.code == 1) {
        setState(() {
          projectList = res.list;
          projectList[0].select = true;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  /// 设备位置 网点列表
  Future _getBranchList(int id, setState) async {
    if (id == 0) {
      setState(() {
        branchList = [];
      });
      return;
    }
    Map params = new Map();
    params['id'] = id;
    Api.getOrgBranchAll(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          branchList = res.list;
          branchList[0].select = true;
        });
      } else {
        showToast(res.msg);
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
    _getDataList();
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
            color:
                subTabsIndex == i ? ColorUtil.color('#CF241C') : Colors.white,
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
        padding: EdgeInsets.all(0),
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
                      builder: (context) => RepairDetail(id: resList[index].id),
                    )).then((data) {
                  setState(() {
                    pageNum = 1;
                    resList = [];
                    isGetAll = false;
                  });
                  _getHomeData();
                  _getDataList();
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                decoration: BoxDecoration(
                  color: ColorUtil.color('#ffffff'),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Text('${resList[index].title}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(2)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(
                                subTabsIndex == 0 ? '#FFE7E6' : '#F2F2F2'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text('${resList[index].statusText}',
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0
                                      ? '#CF241C'
                                      : '#666666'),
                                  fontSize: ScreenUtil().setSp(28),
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '${resList[index].projectName}-${resList[index].organizationBranchName}'),
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
      return ListView(
        children: <Widget>[
          Center(
            child: Image.asset(
              'lib/images/default_no_list.png',
              width: ScreenUtil().setWidth(560),
            ),
          )
        ],
      );
    }
  }

  List<Widget> _projectBuild(BuildContext context, setState) {
    List<Widget> widgets = [];
    if (projectList != null) {
      for (int i = 0; i < projectList.length; i++) {
        widgets.add(GestureDetector(
          onTap: () {
            projectList.forEach((val2) {
              val2.select = false;
            });
            selBranchId = 0;
            projectList[i].select = true;
            _getBranchList(projectList[i].id, setState);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: ScreenUtil().setWidth(2),
                      color: ColorUtil.color('#eeeeee'))),
            ),
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(28),
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(28)),
            child: Text(
              '${projectList[i].name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtil.color(
                      projectList[i].select ? '#CF241C' : '#333333'),
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: projectList[i].select
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ),
        ));
      }
    }
    return widgets;
  }

  List<Widget> _branchBuild(BuildContext context, setState) {
    List<Widget> widgets = [];
    if (branchList != null) {
      for (int i = 0; i < branchList.length; i++) {
        widgets.add(GestureDetector(
          onTap: () {
            branchList.forEach((val2) {
              val2.select = false;
            });
            setState(() {
              branchList[i].select = true;
              selBranchId = branchList[i].id;
            });
          },
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: ScreenUtil().setWidth(2),
                        color: ColorUtil.color('#eeeeee'))),
              ),
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(24),
                  ScreenUtil().setHeight(28),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(28)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${branchList[i].name}',
                    style: TextStyle(
                        color: ColorUtil.color(
                            branchList[i].select ? '#CF241C' : '#333333'),
                        fontSize: ScreenUtil().setSp(28),
                        fontWeight: branchList[i].select
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  Offstage(
                    offstage: !branchList[i].select,
                    child: Image.asset(
                      'lib/images/sel_checked.png',
                      width: ScreenUtil().setWidth(32),
                    ),
                  )
                ],
              )),
        ));
      }
    }
    return widgets;
  }
}
