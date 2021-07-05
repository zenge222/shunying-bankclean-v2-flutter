import 'dart:io';
import 'dart:ui';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/orgBranchVO.dart';
import 'package:bank_clean_flutter/models/selParamsVo.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloorSelect extends StatefulWidget {
  final int id;
  final int orgId;

  const FloorSelect({Key key, this.id, this.orgId})
      : super(key: key); //  99 保养检查

  @override
  _FloorSelectState createState() => _FloorSelectState();
}

class _FloorSelectState extends State<FloorSelect> with ComPageWidget {
  String searchName = "";
  List resList = [];
  bool isLoading = false; // 是否首次数据加载 不关闭-->请求错误或数据返回问题
  bool isGetAll = false; // 数据是否全部获取
  List taskVOList = [];
  int taskId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#ffffff'),
      appBar: AppBar(
        /// 去掉返回按钮
        automaticallyImplyLeading: false,
        title: Text(
          '选择范围',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: false,
        actions: <Widget>[
          FlatButton(
            child: Image.asset(
              'lib/images/floorBack_icon.png',
              width: ScreenUtil().setWidth(48),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        brightness: Brightness.light,
        // 设置状态栏字体颜色 一般有Brightness.dark,和Brightness.light两种模式
        elevation: 0,
        //默认是4， 设置成0 就是没有阴影了
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(40),
                ScreenUtil().setHeight(32),
                ScreenUtil().setWidth(40),
                ScreenUtil().setHeight(32)),
            width: double.infinity,
            child: Wrap(
                spacing: ScreenUtil().setWidth(32),
                //主轴上子控件的间距
                runSpacing: ScreenUtil().setHeight(32),
                //交叉轴上子控件之间的间距
                children: _buildFloors()),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getWorkList();
    setState(() {
      taskId = widget.id;
    });
  }

  Future _getWorkList() async {
    Map params = new Map();
    params['orgId'] = widget.orgId == 0 ? "" : widget.orgId;
    params['taskId'] = taskId == 0 ? "" : taskId;
    Api.taskIndexTaskInfo(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          taskVOList = res.data.taskVOList;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _buildFloors() {
    List<Widget> list = [];
    for (int i = 0; i < taskVOList.length; i++) {
      list.add(GestureDetector(
        onTap: () {
          Navigator.pop(context, taskVOList[i].id);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(16),
              ScreenUtil().setHeight(20),
              ScreenUtil().setWidth(16),
              ScreenUtil().setHeight(20)),
          width: ScreenUtil().setWidth(200),
          decoration: BoxDecoration(
            color: ColorUtil.color(
                taskId == taskVOList[i].id ? '#CF241C' : '#ffffff'),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(8))),
          ),
          child: Center(
            child: Text(
              '${taskVOList[i].title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: ColorUtil.color(
                      taskId == taskVOList[i].id ? '#ffffff' : '#555555')),
            ),
          ),
        ),
      ));
    }
    return list;
  }
}
