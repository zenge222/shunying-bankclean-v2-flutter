import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordItemVO.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectAppraiseDetail extends StatefulWidget {
  final int id;
  final String dateStr;

  const ProjectAppraiseDetail({Key key, this.id, this.dateStr})
      : super(key: key);

  @override
  _ProjectAppraiseDetailState createState() => _ProjectAppraiseDetailState();
}

class _ProjectAppraiseDetailState extends State<ProjectAppraiseDetail>
    with ComPageWidget {
  BranchAssessRecordVO resData;
  bool isLoading = false; // 默认需赋值 或断言

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '考评详情',
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
            ? Column(
                children: <Widget>[
                  /// 头部
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(20),
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(20)),
                    color: Colors.white,
                    child: Center(
                      child: Text('${resData.title}',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(36),
                          )),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(30),
                          right: ScreenUtil().setWidth(30)),
                      child: Column(
                        children: _scoresBuild(resData.itemVOList),
                      ),
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(28),
                    ),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '最终得分：',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(28),
                          )),
                      TextSpan(
                          text: '${resData.aveScore}',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(48),
                          )),
                      TextSpan(
                          text: '分',
                          style: TextStyle(
                            color: ColorUtil.color('#CF241C'),
                            fontSize: ScreenUtil().setSp(24),
                          )),
                      TextSpan(
                          text: '    ${resData.subTitle}',
                          style: TextStyle(
                            color: ColorUtil.color('#333333'),
                            fontSize: ScreenUtil().setSp(36),
                          )),
                    ])),
                  )
                ],
              )
            : Text(''),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
//    print('id:'+widget.id.toString());
//    print('dateStr:'+widget.dateStr);
  }

  Future _getData() async {
    Map params = new Map();
    params['dateStr'] = widget.dateStr;
    params['orgBranchId'] = widget.id;
    Api.getCheckMonthAssessmentDetail(map: params).then((res) {
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

  List<Widget> _scoresBuild(List<BranchAssessRecordItemVO> resList) {
    List<Widget> list = [];
    for(int i=0;i<resList.length;i++){
      list.add(Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(24)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(28)),
                  width: ScreenUtil().setWidth(12),
                  height: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#D5A785'),
                    borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(100)),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16)),
                      child: Text('${resList[i].title}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontSize: ScreenUtil().setSp(36),
                              fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: ColorUtil.color('#F5F6F9'),
                        borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(8)),
                        border: Border.all(
                            width: ScreenUtil().setWidth(2),
                            color: ColorUtil.color(
                                '#EEEEEE'))),
                    width: ScreenUtil().setWidth(192),
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(10),
                        ScreenUtil().setWidth(0),
                        ScreenUtil().setHeight(10)),
                    child: Text('${resList[i].subTitle}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(32),
                        )),
                  ),
                  Text('${resList[i].score}分',
                      style: TextStyle(
                        color: ColorUtil.color('#CF241C'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32),
                      ))
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }
}
