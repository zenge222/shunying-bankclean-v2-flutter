import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/clean/materielApply.dart';
import 'package:bank_clean_flutter/pages/clean/materielDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/provides/materialApply.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class ProjectOutletsCheckList extends StatefulWidget {
  @override
  _ProjectOutletsCheckListState createState() =>
      _ProjectOutletsCheckListState();
}

/// 区域经理(处理)+银行(取消shenq)

class _ProjectOutletsCheckListState extends State<ProjectOutletsCheckList>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点巡检',
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
            /// sel
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(32),
                left: ScreenUtil().setWidth(32),
                bottom: ScreenUtil().setHeight(16),
                right: ScreenUtil().setWidth(32),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
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
                                Text('选择排序',
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
              onTap: (){
                print('asd');
              },
              child: Stack(
                children: <Widget>[
                  Container(
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
                            Row(
                              children: <Widget>[
                                Text('奉贤支行',
                                    style: TextStyle(
                                        color: ColorUtil.color('#333333'),
                                        fontSize: ScreenUtil().setSp(36),
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(12)),
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(10),
                                      ScreenUtil().setHeight(2),
                                      ScreenUtil().setWidth(10),
                                      ScreenUtil().setHeight(2)),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.color('#CF241C'),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(8))),
                                  ),
                                  child: Text('巡检超时',
                                      style: TextStyle(
                                        color: ColorUtil.color('#ffffff'),
                                        fontSize: ScreenUtil().setSp(24),
                                      )),
                                )
                              ],
                            ),
                            Text('时间间隔：10',
                                style: TextStyle(
                                  color: ColorUtil.color('#666666'),
                                  fontSize: ScreenUtil().setSp(28),
                                ))
                          ],
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: Text('巡检员：李某',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                          child: Text('巡检记录：100',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                          child: Text('最近巡检时间：2020.11.17  10:00',
                              style: TextStyle(
                                color: ColorUtil.color('#666666'),
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: ScreenUtil().setHeight(32),
                      right: ScreenUtil().setWidth(32),
                      child: Text(
                        '记录查看>',
                        style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontSize: ScreenUtil().setSp(28)),
                      ))
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

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
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
//    Map params = new Map();
//    params['pageNo'] = pageNum;
//    params['pageSize'] = pageSize;
//    params['status'] = subTabsIndex == 0 ? 1 : (subTabsIndex == 1 ? 2 : 3);
//    Api.getMaterialApplyList(map: params).then((res) {
//      if (res.code == 1) {
//        pageNum++;
//        setState(() {
//          isLoading = false;
//          resList.addAll(res.list);
//        });
//        if (res.list.length < pageSize) {
//          isGetAll = true;
//        }
//      } else {
//        showToast(res.msg);
//      }
//    });
  }
}
