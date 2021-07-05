import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgCheckConfigVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineInspectionAdd extends StatefulWidget {
  final String outletsStr;
  final int outletsId;

  const OnlineInspectionAdd({Key key, this.outletsStr, this.outletsId})
      : super(key: key);

  @override
  _OnlineInspectionAddState createState() => _OnlineInspectionAddState();
}

class _OnlineInspectionAddState extends State<OnlineInspectionAdd>
    with ComPageWidget {
  FocusNode blankNode = FocusNode();
  bool isLoading = false;
  List<OrgCheckConfigVO> resList = [];
  String outStr = ''; //
  String outImage = ''; //
  int outId = 0; //
  String cleanerChat = ''; // 保洁沟通记录
  String customerChat = ''; // 客户沟通记录

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: true,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '新增网点巡检记录',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: LoadingPage(
          isLoading: isLoading,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(32),
                      bottom: ScreenUtil().setHeight(40),
                      right: ScreenUtil().setWidth(32)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// 头部
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OutletsSelect(type: 4),
                              )).then((data) {
                            if (data != null) {
                              print('改变数据');
                              setState(() {
                                outId = data.id;
                                outStr = data.name;
                                outImage = data.baseUrl + data.image;
                                resList=[];
                              });
                              _dataList(data.id);
                            }
                          });
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                          padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                          decoration: BoxDecoration(
                            color: ColorUtil.color('#ffffff'),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setWidth(8))),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  outStr == "''"
                                      ? Image.asset(
                                          'lib/images/def_out_icon.png',
                                          width: ScreenUtil().setWidth(86),
                                        )
                                      : Image.network(
                                          outImage,
                                          width: ScreenUtil().setWidth(86),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(26)),
                                    child: Text(
                                        '${outStr == "''" ? '请选择网点' : outStr}',
                                        style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(36),
                                        )),
                                  )
                                ],
                              ),
                              Image.asset(
                                'lib/images/clean/sel_right.png',
                                width: ScreenUtil().setWidth(32),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                        child: Text('打分情况',
                            style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(36),
                            )),
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
                            Column(
                              children: _scoreList(context),
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
                            Material(
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(56)),
                                child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        customerChat = text;
                                      });
                                    },
                                    maxLines: 5,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                        fontSize: 14,
                                        textBaseline: TextBaseline.alphabetic),
                                    decoration: InputDecoration(
                                      fillColor: ColorUtil.color('#F5F6F9'),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(
                                        ScreenUtil().setSp(20),
                                      ),
                                      hintText: "请输入客户沟通记录",
                                      border: InputBorder.none,
                                      hasFloatingPlaceholder: false,
                                    )),
                              ),
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
                            Material(
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(56)),
                                child: TextField(
                                    onChanged: (text) {
                                      setState(() {
                                        cleanerChat = text;
                                      });
                                    },
                                    maxLines: 5,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                        fontSize: 14,
                                        textBaseline: TextBaseline.alphabetic),
                                    decoration: InputDecoration(
                                      fillColor: ColorUtil.color('#F5F6F9'),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(
                                        ScreenUtil().setSp(20),
                                      ),
                                      hintText: "请输入保洁沟通记录",
                                      border: InputBorder.none,
                                      hasFloatingPlaceholder: false,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Container(
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
                  child: Text('提交',
                      style: TextStyle(
                        color: ColorUtil.color('#ffffff'),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(32),
                      )),
                  onPressed: () {
                    _addSubmit();
                  },
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
    super.initState();
    /// 首次进入请求数据
    setState(() {
      outStr = widget.outletsStr;
      outId = widget.outletsId;
    });
    print(widget.outletsId);
    // 从详情进入
    if(outId!=0){
      _dataList(outId);
    }
  }

  Future _dataList(int id) async {
    setState(() {
      isLoading = true;
    });
    Map params = new Map();
    params['orgBranchId'] = id;
    Api.getOrgConfigList(map: params).then((res) {
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

  Future _addSubmit() async {
    if (outStr == "''") {
      return showToast('请选择网点');
    }
    if (customerChat == "") {
      return showToast('请输入客户沟通记录');
    }
    if (cleanerChat == "") {
      return showToast('请输入保洁沟通记录');
    }
    Map params = new Map();
    params['cleanerChat'] = cleanerChat;
    params['customerChat'] = customerChat;
    params['orgBranchId'] = outId;
    Api.addOrgCheckRecordSubmit(map: params, formData: resList).then((res) {
      if (res.code == 1) {
        Navigator.pop(context, 'init');
      }
      showToast(res.msg);
    });
  }

  List<Widget> _scoreList(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < resList.length; i++) {
      list.add(Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: ScreenUtil().setWidth(1),
                  color: ColorUtil.color('#e5e5e5'))),
        ),
        child: GestureDetector(
          onTap: () {
            var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
            ResetPicker.showStringPicker(context,
                data: list,
                normalIndex: 0,
                title: "选择分数", clickCallBack: (int index, var str) {
              setState(() {
                resList[i].score = str;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(32),
                ScreenUtil().setHeight(36),
                ScreenUtil().setWidth(32),
                ScreenUtil().setHeight(36)),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: ScreenUtil().setWidth(1),
                      color: ColorUtil.color('#EAEAEA'))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text('${resList[i].title}',
                        style: TextStyle(
                          color: ColorUtil.color('#333333'),
                          fontSize: ScreenUtil().setSp(28),
                        ))),
                Container(
                  width: ScreenUtil().setWidth(132),
                  height: ScreenUtil().setHeight(56),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD1D1D1)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(70),
                        child: Text('${resList[i].score}',
                            style: TextStyle(
                              color: ColorUtil.color('#333333'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(28),
                            )),
                        alignment: Alignment.center,
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil().setWidth(56),
                            height: ScreenUtil().setHeight(56),
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              border: Border(
                                  left: BorderSide(color: Color(0xffD1D1D1))),
                            ),
                          ),
                          Positioned(
                              left: ScreenUtil().setWidth(15),
                              height: ScreenUtil().setHeight(50),
                              child: Image.asset(
                                'lib/images/to_score_icon.png',
                                width: ScreenUtil().setWidth(24),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  ' 分',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return list;
  }
}
