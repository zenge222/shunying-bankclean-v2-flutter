import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/taskVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkArrange extends StatefulWidget {
  @override
  _WorkArrangeState createState() => _WorkArrangeState();
}

class _WorkArrangeState extends State<WorkArrange> with ComPageWidget{
  List<TaskVO> resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
//  bool isGetMore = false; // 显示列表加载中
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
          '工作安排',
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
        isLoading: isLoading,
        child: Column(
          children: <Widget>[
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
    });

    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    Api.getCleanerWorkList(map: params).then((res) {
      if(res.code==1){
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
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil().setWidth(8))),
              ),
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40),
                  ScreenUtil().setWidth(32),
                  ScreenUtil().setHeight(40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                          child:  Text('${resList[index].title}',
                              style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontSize: ScreenUtil().setSp(36),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Text('${resList[index].createTime}',
                          style: TextStyle(
                              color: ColorUtil.color('#666666'),
                              fontSize: ScreenUtil().setSp(28),
                              )),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    child: Text('分配人：${resList[0].areaManagerName}',style: TextStyle(
                      color: ColorUtil.color('#666666'),
                      fontSize: ScreenUtil().setSp(28),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                    child: Text('网点：${resList[0].organizationBranchName}',style: TextStyle(
                      color: ColorUtil.color('#666666'),
                      fontSize: ScreenUtil().setSp(28),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                    child: Text('时间：${resList[0].workDate}  ${resList[0].startTime}-${resList[0].endTime}',style: TextStyle(
                      color: ColorUtil.color('#666666'),
                      fontSize: ScreenUtil().setSp(28),
                    )),
                  )
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
