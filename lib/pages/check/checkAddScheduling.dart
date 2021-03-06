import 'dart:io';

import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/taskItemVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/pages/PhotoViewGalleryScreen.dart';
import 'package:bank_clean_flutter/pages/common/cleanSelect.dart';
import 'package:bank_clean_flutter/pages/common/dutyPublicSelect.dart';
import 'package:bank_clean_flutter/pages/common/outletsSelect.dart';
import 'package:bank_clean_flutter/pages/loadingPage.dart';
import 'package:bank_clean_flutter/pages/resetPicker.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:date_format/date_format.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckAddScheduling extends StatefulWidget {
  final String date;
  final int outId;
  final String outStr;

  const CheckAddScheduling({Key key, this.date, this.outId, this.outStr}) : super(key: key);
  @override
  _CheckAddSchedulingState createState() => _CheckAddSchedulingState();
}

class _CheckAddSchedulingState extends State<CheckAddScheduling>
    with ComPageWidget {
  bool isLoading = false;

  List<TaskItemVO> taskList = [];
  DateTime currentDate = new DateTime.now();
  String currentTime = '';
  String startTimeStr = '';
  DateTime startTime = new DateTime.now();
  int taskIndex = 0;
  String endTimeStr = '';
  DateTime endTime = new DateTime.now();
  int outId = 0;
  String outStr = '';
  String dateStr = '';
  int cleanerId = 0;
  String cleanerName = '';
  int taskId = 0;
  String taskStr = '';
  bool isAdd = true;
  GlobalKey _newContentKey = new GlobalKey();
  GlobalKey _newContentKey2 = new GlobalKey();

  /// ??????????????????????????????
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? true
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorUtil.color('#F5F6F9'),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorUtil.color('#333333')),
        title: Text(
          '????????????',
          style: TextStyle(color: ColorUtil.color('#333333')),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        // ??????????????????????????? ?????????Brightness.dark,???Brightness.light????????????
        elevation: 0,
        //?????????4??? ?????????0 ?????????????????????
        backgroundColor: Colors.white,
      ),
      body: LoadingPage(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /// ??????
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OutletsSelect(
                                      type: 3,
                                    ),
                                  )).then((data) {
                                if (data != null) {
                                  print('????????????');
                                  setState(() {
                                    outId = data.id;
                                    outStr = data.name;
                                  });
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Text('??????',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  children: <Widget>[
                                    Text(outStr == '' ? '?????????' : outStr,
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    Container(
                                      width: ScreenUtil().setWidth(32),
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(24)),
                                      child: Image.asset(
                                          'lib/images/clean/sel_right.png'),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  /// ??????
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            /// ???????????????
                            ResetPicker.showDatePicker(context,
                                dateType: DateType.YMD,
                                minValue: DateTime.now(),
                                value: currentDate,
                                clickCallback: (var str, var time) {
                              setState(() {
                                currentTime = str;
                                currentDate = DateTime.parse(time);
                              });
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Text('??????',
                                      style: TextStyle(
                                          color: ColorUtil.color('#333333'),
                                          fontSize: ScreenUtil().setSp(36),
                                          fontWeight: FontWeight.bold))),
                              Row(
                                children: <Widget>[
                                  Text(
                                    currentTime == "" ? '?????????' : currentTime,
                                    style: TextStyle(
                                      color: ColorUtil.color('#666666'),
                                      fontSize: ScreenUtil().setSp(32),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(32),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(24)),
                                    child: Image.asset(
                                        'lib/images/clean/sel_right.png'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ????????????
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text('????????????',
                                style: TextStyle(
                                    color: ColorUtil.color('#333333'),
                                    fontSize: ScreenUtil().setSp(36),
                                    fontWeight: FontWeight.bold))),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                ResetPicker.showDatePicker(context,
                                    dateType: DateType.kHM, title: '??????????????????',
//                                      minValue: DateTime(today.year - 1),
//                                      maxValue: DateTime(today.year + 1,today.month,today.day),
                                    clickCallback: (var str, var time) {
                                  setState(() {
                                    startTimeStr = str;
                                    startTime = DateTime.parse(time);
                                  });
                                });
                              },
                              child: Text(
                                  startTimeStr == '' ? '????????????' : startTimeStr,
                                  style: TextStyle(
                                    color: ColorUtil.color('#666666'),
                                    fontSize: ScreenUtil().setSp(32),
                                  )),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(18),
                              color: ColorUtil.color('#333333'),
                              height: ScreenUtil().setHeight(3),
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(24),
                                  right: ScreenUtil().setWidth(24)),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (startTimeStr == '')
                                  return showToast('?????????????????????');
                                ResetPicker.showDatePicker(context,
                                    dateType: DateType.kHM,
                                    title: '??????????????????',
                                    minValue: startTime,
//                                      maxValue: DateTime(today.year + 1,today.month,today.day),
                                    clickCallback: (var str, var time) {
                                  setState(() {
                                    endTimeStr = str;
                                  });
                                });
                              },
                              child:
                                  Text(endTimeStr == '' ? '????????????' : endTimeStr,
                                      style: TextStyle(
                                        color: ColorUtil.color('#666666'),
                                        fontSize: ScreenUtil().setSp(32),
                                      )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// ??????
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              if (outStr == '') {
                                showToast('??????????????????');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CleanSelect(
                                        id: outId,
                                        type: 5,
                                      ),
                                    )).then((data) {
                                  if (data != null) {
                                    print('????????????');
                                    setState(() {
                                      cleanerId = data.id;
                                      cleanerName = data.name;
                                    });
                                  }
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Text('??????',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        cleanerName == '' ? '?????????' : cleanerName,
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    Container(
                                      width: ScreenUtil().setWidth(32),
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(24)),
                                      child: Image.asset(
                                          'lib/images/clean/sel_right.png'),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  /// ??????
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(32),
                        ScreenUtil().setHeight(24)),
                    padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(8)),
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              if (outStr == '') {
                                showToast('??????????????????');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DutyPublicSelect(
                                        id: outId,
                                      ),
                                    )).then((data) {
                                  if (data != null) {
                                    print('????????????a');
                                    print(data.title);
                                    print(data.id);
                                    setState(() {
                                      taskId = data.id;
                                      taskStr = data.title;
                                      taskList = [];
                                    });
                                    _getData(data.id);
                                  }
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Text('??????',
                                        style: TextStyle(
                                            color: ColorUtil.color('#333333'),
                                            fontSize: ScreenUtil().setSp(36),
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  children: <Widget>[
                                    Text(taskStr == '' ? '?????????' : taskStr,
                                        style: TextStyle(
                                          color: ColorUtil.color('#666666'),
                                          fontSize: ScreenUtil().setSp(32),
                                        )),
                                    Container(
                                      width: ScreenUtil().setWidth(32),
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(24)),
                                      child: Image.asset(
                                          'lib/images/clean/sel_right.png'),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        /// ????????? ??????
                        Offstage(
                          offstage: taskId==0,//false,//taskStr != '?????????',
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(40),
                                    bottom: ScreenUtil().setHeight(16)),
                                width: double.infinity,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(0),
                                      ScreenUtil().setHeight(22)),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: ColorUtil.color('#CF241C'),
                                        width: ScreenUtil().setWidth(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(8))),
                                  color: ColorUtil.color('#ffffff'),
                                  child: Text('+ ????????????',
                                      style: TextStyle(
                                        color: ColorUtil.color('#CF241C'),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(28),
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      isAdd = true;
                                    });
                                    _addWork(context);
                                  },
                                ),
                              ),
                              Column(
                                children: _selfBuild(context),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
                child: Text('??????',
                    style: TextStyle(
                      color: ColorUtil.color('#ffffff'),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                    )),
                onPressed: () {
                  _submitReport();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentTime = widget.date;
       outId = widget.outId;
       outStr = widget.outStr;
    });
    /// ?????????initState ???flutter??????????????????????????????????????????????????????????????????????????????
    _titleController.addListener(() {
      final text = _titleController.text.toLowerCase();
      _titleController.value = _titleController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    _contentController.addListener(() {
      final text = _contentController.text.toLowerCase();
      _contentController.value = _contentController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  Future _getData(int id) async {
    isLoading = true;
    Map params = new Map();
    params['taskId'] = id;
    Api.getTaskDetail(map: params).then((res) {
      if (res.code == 1) {
        setState(() {
          isLoading = false;
          taskList = res.data.taskItemVOList;
        });
      } else {
        showToast(res.msg);
      }
    });
  }

  List<Widget> _selfBuild(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < taskList.length; i++) {
      list.add(Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(32)),
        decoration: BoxDecoration(
          color: ColorUtil.color('#F5F6F9'),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8)),
        ),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${taskList[i].startTime}-${taskList[i].endTime}',
                    style: TextStyle(
                      color: ColorUtil.color('#333333'),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(32),
                    )),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAdd = false;
                          taskIndex = i;
                        });
                        _addWork(context);
                      },
                      child: Text('??????',
                          style: TextStyle(
                            color: ColorUtil.color('#375ECC'),
                            fontSize: ScreenUtil().setSp(32),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        showCustomDialog(context, '????????????', () {
                          setState(() {
                            taskList.remove(taskList[i]);
                          });
                          Application.router.pop(context);
                        });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                        child: Text('??????',
                            style: TextStyle(
                              color: ColorUtil.color('#CF241C'),
                              fontSize: ScreenUtil().setSp(32),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              child: Text('${taskList[i].title}',
                  style: TextStyle(
                    color: ColorUtil.color('#333333'),
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(32),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Text('${taskList[i].content}',
                  style: TextStyle(
                    color: ColorUtil.color('#333333'),
                    fontSize: ScreenUtil().setSp(32),
                  )),
            ),
          ],
        ),
      ));
    }
    return list;
  }

  void _addWorkList(TaskItemVO item) {
    if (_titleController.text == '') return showToast('???????????????');
    if (item.startTime == '') return showToast('?????????????????????');
    if (item.endTime == '') return showToast('?????????????????????');
    if (_contentController.text == '') return showToast('?????????????????????');
    TaskItemVO itemVo = new TaskItemVO();
    itemVo.title = _titleController.text;
    itemVo.content = _contentController.text;
    itemVo.startTime = item.startTime;
    itemVo.endTime = item.endTime;
    if (isAdd) {
      setState(() {
        taskList.add(itemVo);
      });
    } else {
      setState(() {
        taskList[taskIndex] = itemVo;
      });
    }
    Application.router.pop(context);
  }

  void _addWork(BuildContext context) {
    showDialog<Null>(
        context: context,
        // ????????????????????????????????????
        barrierDismissible: false,
        builder: (context) {
          TaskItemVO workItem = new TaskItemVO();
          if (isAdd) {
//            workItem.content = '';
            _titleController.text = '';
            workItem.statusText = '';
//            workItem.title = '';
            _contentController.text = '';
            workItem.startTime = '';
            workItem.endTime = '';
            workItem.status = -1;
          } else {
            _titleController.text = taskList[taskIndex].title;
//            workItem.title = taskList[taskIndex].title;
            workItem.startTime = taskList[taskIndex].startTime;
            workItem.endTime = taskList[taskIndex].endTime;
            _contentController.text = taskList[taskIndex].content;
//            workItem.content = taskList[taskIndex].content;
          }
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: ScreenUtil().setWidth(600),
                  decoration: BoxDecoration(
                    color: ColorUtil.color('#FDFAFE'),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(30),
                            bottom: ScreenUtil().setHeight(20)),
                        child: Text(
                          '????????????',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(36),
                              color: Color.fromRGBO(0, 0, 0, 0.8)),
                        ),
                      ),

                      /// ??????
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(24),
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(0)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#F5F6F9'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(20),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '??????',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.8)),
                            ),
                            Material(
                              child: Container(
                                width: ScreenUtil().setWidth(400),
                                child: TextField(
                                    key: _newContentKey,
                                    controller: _titleController,
                                    onChanged: (text) {
                                      setState(() {
//                                    reason = text;
                                      });
                                    },
                                    inputFormatters: <TextInputFormatter>[
//                                    WhitelistingTextInputFormatter.digitsOnly,//???????????????
                                      LengthLimitingTextInputFormatter(10)
                                      //????????????
                                    ],
                                    textAlign: TextAlign.right,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        color: ColorUtil.color('#333333'),
                                        textBaseline: TextBaseline.alphabetic),
                                    decoration: InputDecoration(
                                      fillColor: ColorUtil.color('#F5F6F9'),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(
                                        ScreenUtil().setSp(20),
                                      ),
                                      hintText: "?????????",
                                      border: InputBorder.none,
                                      //????????????????????????),
                                      hasFloatingPlaceholder: false,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),

                      /// ??????
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(24),
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(0)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#F5F6F9'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(32),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(32)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '??????',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.8)),
                            ),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    /// ????????????
                                    ResetPicker.showDatePicker(context,
                                        dateType: DateType.kHM,
//                                      minValue: DateTime.now(),
//                                      value: DateTime.now(), //  DateTime(2020,10,10)
                                        clickCallback: (var str, var time) {
                                      setState(() {
                                        workItem.startTime = str;
                                        startTime = DateTime.parse(time);
                                      });
                                      print(workItem.startTime);
                                    });
                                  },
                                  child: Text(
                                      '${workItem.startTime == '' ? '?????????' : workItem.startTime}',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        decoration: TextDecoration.none,
                                        color: ColorUtil.color('#333333'),
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(0),
                                      ScreenUtil().setWidth(32),
                                      ScreenUtil().setHeight(0)),
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setHeight(3),
                                  color: ColorUtil.color('#333333'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /// ????????????
                                    if (workItem.startTime == '')
                                      return showToast('?????????????????????');
                                    ResetPicker.showDatePicker(context,
                                        dateType: DateType.kHM,
                                        minValue: startTime,
//                                      value: DateTime.now(), //  DateTime(2020,10,10)
                                        clickCallback: (var str, var time) {
                                      setState(() {
                                        workItem.endTime = str;
                                      });
                                    });
                                  },
                                  child: Text(
                                      '${workItem.endTime == '' ? '?????????' : workItem.endTime}',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        decoration: TextDecoration.none,
                                        color: ColorUtil.color('#333333'),
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      /// ??????
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(24),
                            ScreenUtil().setWidth(24),
                            ScreenUtil().setHeight(0)),
                        decoration: BoxDecoration(
                          color: ColorUtil.color('#F5F6F9'),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(8))),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(20),
                            ScreenUtil().setWidth(32),
                            ScreenUtil().setHeight(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '??????',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.8)),
                            ),
                            Material(
                              child: Container(
                                width: double.infinity,
                                child: TextField(
                                    key: _newContentKey2,
                                    controller: _contentController,
                                    onChanged: (text) {
                                      setState(() {
//                                      content = text;
                                      });
                                    },
                                    inputFormatters: <TextInputFormatter>[
//                                    WhitelistingTextInputFormatter.digitsOnly,//???????????????
                                      LengthLimitingTextInputFormatter(300)
                                      //????????????
                                    ],
                                    maxLines: 5,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        textBaseline: TextBaseline.alphabetic),
                                    decoration: InputDecoration(
                                      fillColor: ColorUtil.color('#F5F6F9'),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(
                                        ScreenUtil().setSp(20),
                                      ),
                                      hintText: "?????????????????????",
                                      border: InputBorder.none,
                                      hasFloatingPlaceholder: false,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),

                      /// ????????????
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: ColorUtil.color('#ededed'))),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorUtil.color('#EAEAEA'),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          ScreenUtil().setWidth(14))),
                                ),
                                child: OutlineButton(
                                  onPressed: () async {
                                    Application.router.pop(context);
                                  },
                                  borderSide: BorderSide.none,
                                  child: Text(
                                    '??????',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        color: ColorUtil.color('#333333')),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorUtil.color('#CF241C'),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          ScreenUtil().setWidth(14))),
                                ),
                                child: OutlineButton(
                                  onPressed: () async {
                                    _addWorkList(workItem);
                                  },
                                  borderSide: BorderSide.none,
                                  child: Text(
                                    '??????',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32),
                                        color: ColorUtil.color('#ffffff')),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future _submitReport() async {
    if (outStr == "") {
      showToast('???????????????');
    } else if (currentTime == '') {
      showToast('???????????????');
    } else if (startTimeStr == '') {
      showToast('?????????????????????');
    } else if (endTimeStr == '') {
      showToast('?????????????????????');
    } else if (cleanerId == 0) {
      showToast('???????????????');
    } else if (taskId == 0) {
      showToast('???????????????');
    } else {
      if(taskList.length==0) return showToast('????????????????????????');
      Map params = new Map();
      params['cleanerId'] = cleanerId;
      params['dateStr'] = currentTime;
      params['startTimeStr'] = startTimeStr;
      params['endTimeStr'] = endTimeStr;
      params['orgBranchId'] = outId;
      params['selectTaskId'] = -1;
      params['title'] = taskStr;
      Api.taskAddCommit(map: params, formData: taskList).then((res) {
        if (res.code == 1) {
          Navigator.pop(context, 'init');
        }
        showToast(res.msg);
      });
    }
  }
}
