import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/checkMaterielExamine.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegionMaterialArea extends StatefulWidget {
  @override
  _RegionMaterialAreaState createState() => _RegionMaterialAreaState();
}

class _RegionMaterialAreaState extends State<RegionMaterialArea>
    with ComPageWidget {
  List resList = [1, 2, 3];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料区域',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: ScreenUtil().setHeight(1),
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(32),
                right: ScreenUtil().setWidth(32),
              ),
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
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
    super.initState();
    _getList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getList();
      }
    });
  }

  Future _getList() async {
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    Api.getToolsApplyAreaList(map: params).then((res) {
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
                      builder: (context) => CheckMaterielExamine(
                        id: resList[index].id,
                      ),
                    )).then((data) {
                  if (data == "init") {
                    setState(() {
                      resList = [];
                      pageNum = 1;
                    });
                    _getList();
                  }
                });
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(8))),
                ),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(20),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setHeight(0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: ScreenUtil().setWidth(444),
                                ),
                                child: Text('${resList[index].name}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(36),
                                      color: ColorUtil.color('#333333'),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(2),
                                ScreenUtil().setWidth(10),
                                ScreenUtil().setHeight(2)),
                            decoration: BoxDecoration(
                              color: ColorUtil.color(resList[index].status == 1
                                  ? '#FFE7E6'
                                  : '#f2f2f2'),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(8))),
                            ),
                            child: Text('${resList[index].statusText}',
                                style: TextStyle(
                                    color: ColorUtil.color(
                                        resList[index].status == 1
                                            ? '#CF241C'
                                            : '#666666'),
                                    fontSize: ScreenUtil().setSp(28),
                                    fontWeight: FontWeight.bold)),
                          )
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
                              Text('网点数：${resList[index].orgBranchCount}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(28),
                                    color: ColorUtil.color('#333333'),
                                  )),
                            ],
                          ),
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
          'lib/images/default_no_list.png',
          width: ScreenUtil().setWidth(560),
        ),
      );
    }
  }
}
