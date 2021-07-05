import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/materielExamineDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckMaterielExamine extends StatefulWidget {
  final int id;

  const CheckMaterielExamine({Key key, this.id}) : super(key: key);

  @override
  _CheckMaterielExamineState createState() => _CheckMaterielExamineState();
}

/// 区域经理
class _CheckMaterielExamineState extends State<CheckMaterielExamine>
    with ComPageWidget {
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = true; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 9999;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料审核',
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
        isLoading: false,
        child: Container(
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
              Offstage(
                offstage: false,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(80),
                      ScreenUtil().setHeight(16),
                      ScreenUtil().setWidth(80),
                      ScreenUtil().setHeight(16)),
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(20),
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(20)),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(60))),
                    color: ColorUtil.color('#CF241C'),
                    child: Text('提交核算',
                        style: TextStyle(
                          color: ColorUtil.color('#ffffff'),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(32),
                        )),
                    onPressed: () {
                      /// 全部提交
                      _submitAll(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
      pageNum = 1;
      isGetAll = true;
      resList = [];
    });
    print('widget.id:' + widget.id.toString());
    _getList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
//        _getDataList();
      }
    });
  }

  // getToolsOrgBranchList
  Future _getList() async {
    Map params = new Map();
    params['areaId'] = widget.id;
    Api.getToolsOrgBranchList(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          resList.addAll(res.list);
        });
      } else {
        showToast(res.msg);
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
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MaterielExamineDetail(
                        id: resList[index].orgBranchId,
                      ),
                    )).then((data) {
                  if (data == 'init') {
                    print('刷新list');
                    setState(() {
                      pageNum = 1;
                      resList = [];
                    });
                    _getList();
                  }
                });
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
                            Text('${resList[index].orgBranchName}',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold)),
                            Offstage(
                              offstage: resList[index].overBudget == 2,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(0),
                                    ScreenUtil().setWidth(6),
                                    ScreenUtil().setHeight(0)),
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(14)),
                                decoration: BoxDecoration(
                                  color: ColorUtil.color('#CF241C'),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(4))),
                                ),
                                child: Text('超额',
                                    style: TextStyle(
                                      color: ColorUtil.color('#ffffff'),
                                      fontSize: ScreenUtil().setSp(24),
                                    )),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(6),
                              ScreenUtil().setHeight(0),
                              ScreenUtil().setWidth(6),
                              ScreenUtil().setHeight(0)),
                          margin:
                              EdgeInsets.only(left: ScreenUtil().setWidth(14)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color(resList[index].status == 2
                                ? '#FFE7E6'
                                : '#ECF1FF'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(4))),
                          ),
                          child: Text('${resList[index].statusText}',
                              style: TextStyle(
                                color: ColorUtil.color(
                                    resList[index].status == 2
                                        ? '#CF241C'
                                        : '#375ECC'),
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(28),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: Text('申请人：${resList[index].applyCleanerNames}',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                      child: Text('共${resList[index].sumQuantity}件物料',
                          style: TextStyle(
                            color: ColorUtil.color('#666666'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/images/default_no_list.png',
              width: ScreenUtil().setWidth(560),
            ),
//            Container(
//              width: ScreenUtil().setWidth(336),
//              margin: EdgeInsets.fromLTRB(
//                  ScreenUtil().setWidth(0),
//                  ScreenUtil().setHeight(80),
//                  ScreenUtil().setWidth(0),
//                  ScreenUtil().setHeight(0)),
//              child: FlatButton(
//                padding: EdgeInsets.fromLTRB(
//                    ScreenUtil().setWidth(0),
//                    ScreenUtil().setHeight(20),
//                    ScreenUtil().setWidth(0),
//                    ScreenUtil().setHeight(20)),
//                shape: RoundedRectangleBorder(
//                    side: BorderSide(
//                      color: ColorUtil.color('#CF241C'),
//                      width: ScreenUtil().setWidth(2),
//                    ),
//                    borderRadius:
//                        BorderRadius.circular(ScreenUtil().setWidth(60))),
//                color: ColorUtil.color('#ffffff'),
//                child: Text('查看物料记录',
//                    style: TextStyle(
//                      color: ColorUtil.color('#CF241C'),
//                      fontWeight: FontWeight.bold,
//                      fontSize: ScreenUtil().setSp(32),
//                    )),
//                onPressed: () {},
//              ),
//            )
          ],
        ),
      );
    }
  }

  Future _submitAll(BuildContext context) async {
    Map params = new Map();
    params['areaId'] = widget.id;
    Api.materielAllCommit(map: params).then((res) {
      if (res.code == 1) {
        Navigator.of(context).pop('init');
      }
      showToast(res.msg);
    });
  }
}
