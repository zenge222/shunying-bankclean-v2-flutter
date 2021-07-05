import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgCheckRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineInspectionDetail extends StatefulWidget {
  final int id;

  const OnlineInspectionDetail({Key key, this.id}) : super(key: key);

  @override
  _OnlineInspectionDetailState createState() => _OnlineInspectionDetailState();
}

/// 巡检(可新增记录)+项目经理
class _OnlineInspectionDetailState extends State<OnlineInspectionDetail>
    with ComPageWidget {
  bool isLoading = false;
  OrgCheckRecordVO resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '网点巡检详情',
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
        isLoading: isLoading,
        child: resData != null
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(32),
                      right: ScreenUtil().setWidth(32)),
                  child: Column(
                    children: <Widget>[
                      /// 头部
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#ffffff'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Row(
                          children: <Widget>[
                            Image.network(
                              '${resData.baseUrl!=null?resData.baseUrl+resData.orgImage:'' }',
                              width: ScreenUtil().setWidth(86),
                            ),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(26)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${resData.organizationBranchName}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(36),
                                          )),
                                      Text('${resData.createTime}',
                                          style: TextStyle(
                                            color: ColorUtil.color('#666666'),
                                            fontSize: ScreenUtil().setSp(28),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(10)),
                                    child:
                                        Text('巡检员：${resData.areaManagerName}',
                                            style: TextStyle(
                                              color: ColorUtil.color('#666666'),
                                              fontSize: ScreenUtil().setSp(28),
                                            )),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),

                      /// 打分情况
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#ffffff'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(32),
                                  ScreenUtil().setHeight(26),
                                  ScreenUtil().setWidth(32),
                                  ScreenUtil().setHeight(26)),
                              child: Text('打分情况',
                                  style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(28),
                                  )),
                            ),
                            Column(
                              children: _scoreList(),
                            )
                          ],
                        ),
                      ),

                      /// 客户沟通记录
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#ffffff'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('客户沟通记录',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(36),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20)),
                              child: Text('${resData.bankChatContent}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#666666'),
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                            )
                          ],
                        ),
                      ),

                      /// 保洁沟通记录
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#ffffff'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('保洁沟通记录',
                                style: TextStyle(
                                  color: ColorUtil.color('#333333'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(36),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20)),
                              child: Text('${resData.cleanerChatContent}',
                                  style: TextStyle(
                                    color: ColorUtil.color('#666666'),
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Text(''),
      ),
    );
  }

  @override
  void initState() {
    /// 首次进入请求数据
    setState(() {
      isLoading = true;
    });
    _getData();
  }

  Future _getData() async {
    Map params = new Map();
    params['recordId'] = widget.id;
    Api.getOrgCheckRecordDetail(map: params).then((res) {
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

  List<Widget> _scoreList() {
    List<Widget> list = [];
    resData.recordItemVOList.forEach((val) {
      list.add(Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: ScreenUtil().setWidth(1),
                  color: ColorUtil.color('#e5e5e5'))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${val.title}',
                style: TextStyle(
                  color: ColorUtil.color('#333333'),
                  fontSize: ScreenUtil().setSp(28),
                )),
            Text('${val.checkScore}分',
                style: TextStyle(
                  color: ColorUtil.color('#CF241C'),
                  fontSize: ScreenUtil().setSp(28),
                )),
          ],
        ),
      ));
    });
    return list;
  }
}
