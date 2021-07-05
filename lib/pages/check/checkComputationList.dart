import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/areaVO.dart';
import 'package:bank_clean_flutter/models/toolsCheckRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/check/materielComputationDetail.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/projectManager/projectMaterielComputationDetail.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckComputationList extends StatefulWidget {
  final int index;

  const CheckComputationList({Key key, this.index}) : super(key: key);

  @override
  _CheckComputationListState createState() => _CheckComputationListState();
}

/// 区域经理+主管(有选择区域)
class _CheckComputationListState extends State<CheckComputationList>
    with ComPageWidget {
  List<ToolsCheckRecordVO> resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetMore = false; // 显示列表加载中
  bool isGetAll = false; // 数据是否全部获取
  ScrollController _scrollController = ScrollController();
  int pageNum = 1;
  int pageSize = 5;
  List<String> subTabs = ['待审批', '已通过', '未通过', '已失效'];
  int subTabsIndex = 0;
  String type = '';
  String selStr = '';
  int selId = 0;
  List selList = [];
  List<AreaVO> areaList = [];
  int selIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '物料核算',
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

            /// sel
            Offstage(
              offstage: type != '5',
              child: Container(
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
                            onTap: () {
                              areaList.forEach((val){
                                selList.add(val.name);
                              });
                              ResetPicker.showStringPicker(context,
                                  data: selList,
                                  normalIndex: selIndex,
                                  title: "选择区域",
                                  clickCallBack: (int index, var str) {
                                    setState(() {
                                      pageNum = 1;
                                      isGetAll = false;
                                      resList = [];
                                      selStr = str;
                                      selId = areaList[index].id;
                                      selIndex = index;
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
                                  Text(selStr==""?'选择区域':selStr,
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
      subTabsIndex = widget.index;
      isLoading = true;
      isGetAll = false;
      resList = [];
    });
    _getAreaList();
    /// 项目经理

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMaterialApplyList();
      }
    });
  }

  Future _getAreaList()async{
    String resType = await SharedPreferencesUtil.getType();
    setState(() {
      type = resType;
    });
    if(type=="5"){
      Api.getAreaList().then((res){
        if(res.code==1){
          setState(() {
            areaList = res.list;
          });
        }else{
          showToast(res.msg);
        }
      });
    }
    _getMaterialApplyList();
  }

  Future _getMaterialApplyList() async {

    /// 如无更多数据
    if (isGetAll) return;
    Map params = new Map();
    params['pageNo'] = pageNum;
    params['pageSize'] = pageSize;
    params['status'] = subTabsIndex+1;
    /// 项目经理 + 区域
    if(type=="5"){
       params['areaId'] = selId;
    }
    Api.getToolsCheckRecordList(map: params).then((res) {
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
              onTap: () async {
                String type = await SharedPreferencesUtil.getType();

                /// 区域经理 3 + 项目经理 5 跳转不同详情
//                if (type == '3') {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => MaterielComputationDetail(
//                          id: resList[index].id,
//                        ),
//                      )).then((data) {
//                    if (data == 'init') {
//                      print('刷新list');
//                      setState(() {
//                        pageNum = 1;
//                        isGetAll = false;
//                        resList = [];
//                      });
//                      _getMaterialApplyList();
//                    }
//                  });
//                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectMaterielComputationDetail(
                          id: resList[index].id,
                        ),
                      )).then((data) {
                    if (data == 'init') {
                      print('刷新list');
                      setState(() {
                        pageNum = 1;
                        isGetAll = false;
                        resList = [];
                      });
                      _getMaterialApplyList();
                    }
                  });
//                }
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
                                ? '#FFE7E6'
                                : (subTabsIndex == 1
                                    ? '#ECF1FF'
                                    : (subTabsIndex == 2
                                        ? '#F2F2F2'
                                        : '#F2F2F2'))),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Text('${resList[index].statusText}',
                              style: TextStyle(
                                  color: ColorUtil.color(subTabsIndex == 0
                                      ? '#CF241C'
                                      : (subTabsIndex == 1
                                          ? '#375ECC'
                                          : (subTabsIndex == 2
                                              ? '#666666'
                                              : '#666666'))),
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
                          Text('提交人：${resList[index].areaManagerName}',
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
