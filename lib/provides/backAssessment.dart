import 'package:bank_clean_flutter/http/Api.dart';
import 'package:bank_clean_flutter/models/branchAssessRecordVO.dart';
import 'package:bank_clean_flutter/pages/ComPageWidget.dart';
import 'package:bank_clean_flutter/router/Application.dart';
import 'package:bank_clean_flutter/router/Routers.dart';
import 'package:bank_clean_flutter/utils/SharedPreferencesUtil.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackAssessmentProvide with ChangeNotifier, ComPageWidget {
  List<BranchAssessRecordVO> examineList = [];
  int dateInt = 0;
  DateTime currentDate = DateTime.now();
  changeDate(int date){
    dateInt = date;
  }
  changeCurrentDate(DateTime date){
    currentDate = date;
  }
  changeList(List<BranchAssessRecordVO> list) {
    examineList = [];
    examineList.addAll(list);
    notifyListeners();
  }
}
