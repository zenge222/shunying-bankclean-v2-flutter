import 'package:bank_clean_flutter/models/ToolsVO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialApplyProvide with ChangeNotifier {
  int materialId = 0;
  String applyReason = '';
  String applyMark = '';
  List<ToolsVO> applyList = [];
  changeId(int id) {
    materialId = id;
    notifyListeners();
  }

  changeReason(String reason, String mark) {
    applyMark = mark;
    applyReason = reason;
    notifyListeners();
  }

  changeList(List<ToolsVO> list) {
    applyList = list;
    notifyListeners();
  }

  initData() {
    print('initData');
    materialId = 0;
    applyReason = "";
    applyMark = "";
    applyList = [];
    notifyListeners();
  }
}
