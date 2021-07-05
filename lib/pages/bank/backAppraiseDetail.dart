import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordItemVO.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/models/itemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackAppraiseDetail extends StatefulWidget {
  /// 0 添加 1查看
  final int type;
  final int id;

  const BackAppraiseDetail({Key key, this.type, this.id}) : super(key: key);

  @override
  _BackAppraiseDetailState createState() => _BackAppraiseDetailState();
}

class _BackAppraiseDetailState extends State<BackAppraiseDetail>
    with ComPageWidget {
  BranchAssessRecordVO resData;
  bool isLoading = false;
  bool canSubmit = true;

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
                        children: _buildList(),
                      ),
                    ),
                  )),
                  Offstage(
                    offstage: widget.type == 1,
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
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(60))),
                        color: ColorUtil.color('#CF241C'),
                        child: Text('提交',
                            style: TextStyle(
                              color: ColorUtil.color('#ffffff'),
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(32),
                            )),
                        disabledColor: ColorUtil.color('#E1E1E1'),

                        /// _isDisabled
                        onPressed: false
                            ? null
                            : () {
                                _submitScore();
                              },
                      ),
                    ),
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
    setState(() {
      isLoading = true;
    });
    _getData();
    print(widget.type);
    print(widget.id);
  }

  Future _getData() async {
    /// 查看
    if (widget.type == 1) {
      Map params = new Map();
      params['id'] = widget.id;
      Api.getBranchAssessRecordDetail(map: params).then((res) {
        if (res.code == 1) {
          setState(() {
            isLoading = false;
            resData = res.data;
          });
        } else {
          showToast(res.msg);
        }
      });
    } else {
      Api.branchAssessRecordAdd().then((res) {
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
  }

  Future _submitScore() async {
    int orgBranchId = await SharedPreferencesUtil.getBankId();
    canSubmit = true;
    resData.itemVOList.forEach((val) {
      if (val.subTitle == null || val.subTitle == "") {
        canSubmit = false;
        return;
      }
    });
    if (canSubmit) {
      Map params = new Map();
      params['orgBranchId'] = orgBranchId;
      Api.submitBranchAssessRecord(map: params, formData: resData).then((res) {
        /// code == 0  已考评
        if (res.code == 1) {
          Navigator.of(context).pop('init');
        }
        showToast(res.msg);
      });
    } else {
      showToast('请选择');
    }
  }

  List<Widget> _buildList() {
    List<Widget> list = [];

    List<BranchAssessRecordItemVO> resList = resData.itemVOList;
    for (int i = 0; i < resList.length; i++) {
      list.add(Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                  width: ScreenUtil().setWidth(12),
                  height: ScreenUtil().setHeight(12),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#D5A785'),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(100)),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
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
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: widget.type == 0
                  ? Wrap(
                      spacing: ScreenUtil().setWidth(24),
                      //主轴上子控件的间距
//                                runSpacing: ScreenUtil().setHeight(22),
                      //交叉轴上子控件之间的间距
                      children: _buildScore(resList[i].subTitleList, i),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: ColorUtil.color('#F5F6F9'),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                          border: Border.all(
                              width: ScreenUtil().setWidth(2),
                              color: ColorUtil.color('#EEEEEE'))),
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
            )
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> _buildScore(List<ItemVO> subTitleList, int i) {
    List<Widget> list = [];
    subTitleList.forEach((val) {
      list.add(
        GestureDetector(
          onTap: () {
            subTitleList.forEach((val1) {
              val1.select = false;
            });
            setState(() {
              val.select = true;
              resData.itemVOList[i].subTitle = val.value;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: ColorUtil.color('#F5F6F9'),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
                border: Border.all(
                    width: ScreenUtil().setWidth(2),
                    color:
                        ColorUtil.color(val.select ? '#CF241C' : '#EEEEEE'))),
            width: ScreenUtil().setWidth(192),
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(10),
                ScreenUtil().setWidth(0),
                ScreenUtil().setHeight(10)),
            child: Text('${val.value}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorUtil.color(val.select ? '#CF241C' : '#333333'),
                  fontSize: ScreenUtil().setSp(32),
                )),
          ),
        ),
      );
    });
    return list;
  }
}
