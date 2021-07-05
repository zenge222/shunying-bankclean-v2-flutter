import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkNoticeDetail.dart';
import 'package:bank_clean_flutter/pages/check/examineNoticeDetail.dart';
import 'package:bank_clean_flutter/pages/clean/eventDetail.dart';
import 'package:bank_clean_flutter/pages/common/message/messageDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
//  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;
  List<ItemVO> itemVOList = [];
  List dateList = [];
  String currentDate = '';
  int dateIndex = 0;
  int duringDate = 0; // 请求参数
  List<String> subTabs = ['未读', '已读'];
  int subTabsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '消息通知',
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
    _getDataList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getDataList();
      }
    });
  }

  Future _getDataList() async {
    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['readStatus'] = subTabsIndex == 0 ? 1 : 2;
    Api.getMessageList(map: params).then((res) {
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
                _messageDetail(context, resList[index].readStatus,
                    resList[index].id, resList[index].type);
              },
              child: Container(
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
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('${resList[index].title}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          '${resList[index].createTime}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(28),
                              color: ColorUtil.color('#666666')),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${resList[index].subTitle}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28),
                                  color: ColorUtil.color('#666666'))),
                          Text(
                              '${resList[index].readStatus == 1 ? '未读' : '已读'}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28),
                                  fontWeight: FontWeight.bold,
                                  color: ColorUtil.color(
                                      resList[index].readStatus == 1
                                          ? '#CF241C'
                                          : '#999999')))
                        ],
                      ),
                    ),
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
          'lib/images/clean/no_clean_feedback_list.png',
          width: ScreenUtil().setWidth(560),
        ),
      );
    }
  }

  void _messageDetail(BuildContext context, int readStatus, int id, int type) {
    String title = type == 1 ? '事件详情' : (type == 2 ? '审核通知详情' : '巡检通知详情');
    if (readStatus == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageDetail(
              id: id,
              type: type,
              title: title,
            ),
          )).then((data) {
        print('刷新list');
        setState(() {
          pageNum = 1;
          resList = [];
          isGetAll = false;
        });
        _getDataList();
      });
    } else {
      Application.router.navigateTo(
          context,
          Routers.messageDetail +
              '?id=${id}&type=${type}&title=${Uri.encodeComponent(title)}',
          transition: TransitionType.inFromRight);
    }
//    switch (type) {
//      case 1:
//      /// 事件详情
//        if (readStatus == 1) {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => EventDetail(
//                  id: id,
//                ),
//              )).then((data) {
//            print('刷新list');
//            setState(() {
//              pageNum = 1;
//              resList = [];
//              isGetAll = false;
//            });
//            _getDataList();
//          });
//        } else {
//          Application.router.navigateTo(context, Routers.eventDetail+'?id=${id}',
//              transition: TransitionType.inFromRight);
//        }
//        break;
//      case 2:
//
//      /// 审核通知详情
//        if (readStatus == 1) {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => ExamineNoticeDetail(
//                  id: id,
//                ),
//              )).then((data) {
//            print('刷新list');
//            setState(() {
//              pageNum = 1;
//              resList = [];
//              isGetAll = false;
//            });
//            _getDataList();
//          });
//        } else {
//          Application.router.navigateTo(context, Routers.examineNoticeDetail+'?id=${id}',
//              transition: TransitionType.inFromRight);
//        }
//        break;
//      case 3:
//
//        /// 巡检通知详情
//        if (readStatus == 1) {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => CheckNoticeDetail(
//                  id: id,
//                ),
//              )).then((data) {
//            print('刷新list');
//            setState(() {
//              pageNum = 1;
//              resList = [];
//              isGetAll = false;
//            });
//            _getDataList();
//          });
//        } else {
//          Application.router.navigateTo(context, Routers.checkNoticeDetail+'?id=${id}',
//              transition: TransitionType.inFromRight);
//        }
//        break;
//    }
  }
}
