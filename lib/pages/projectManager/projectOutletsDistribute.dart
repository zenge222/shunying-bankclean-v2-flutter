import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/eventReport.dart';
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

class ProjectOutletsDistribute extends StatefulWidget {
  @override
  _ProjectOutletsDistributeState createState() =>
      _ProjectOutletsDistributeState();
}
/// 项目经理
class _ProjectOutletsDistributeState extends State<ProjectOutletsDistribute>
    with ComPageWidget {
  List<OrgBranchVO> resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<String> subTabs = ['待分配', '已分配'];
  int subTabsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点分配',
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
        child: Column(
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
                  children: _items(context),
                ),
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
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
      isGetAll = false;
      resList = [];
      pageNum = 1;
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
    params['allocation'] = subTabsIndex == 0 ? 1 : 2;
    Api.getAllocationList(map: params).then((res) {
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
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
              ),
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${resList[index].name}',
                          style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontSize: ScreenUtil().setSp(36),
                              fontWeight: FontWeight.bold)),
                      Container(
                        margin:
                        EdgeInsets.only(top: ScreenUtil().setHeight(16),right: ScreenUtil().setHeight(20)),
                        child: Text('${resList[index].address}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                                fontWeight: FontWeight.bold)),
                      ),
                      subTabsIndex == 0
                          ? Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10)),
                        child: Text('未分配巡检',
                            style: TextStyle(
                              color: ColorUtil.color('#CD8E5F'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                      )
                          : Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10)),
                        child: Text('${resList[index].areaManagerName}   ${resList[index].areaManagerPhone}',
                            style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                            )),
                      ),
                    ],
                  )),
                  Container(
                    width: ScreenUtil().setWidth(136),
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
                          color: ColorUtil.color(subTabsIndex == 0?'#ffffff':'#CF241C'),
                          width: ScreenUtil().setWidth(1),
                        ),
                      ),
                      color: ColorUtil.color(subTabsIndex == 0 ?'#CF241C':'#ffffff'),
                      child: Text(subTabsIndex == 0 ? '分配' : '修改',
                          style: TextStyle(
                            color: ColorUtil.color(subTabsIndex == 0?'#ffffff':'#CF241C'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(28),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectOutletsDetail(id:resList[index].id),
                            )).then((data) {
                          if (data == 'init') {
                            print('刷新list');
                            setState(() {
                              pageNum = 1;
                              resList = [];
                              isGetAll = false;
                            });
                            _getMoreData();
                          }
                        });
                      },
                    ),
                  ),
                ],
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
