
class HttpResponse<T> {
  int code;
  String msg;
  Map<String, dynamic> dataMap;
  List<dynamic> dataList;
  T data;
  List<T> list = new List();
  String value = "";

  HttpResponse.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.msg = json['msg'];

    if(json['data'] is Map){
      this.dataMap = json['data'];
    }else if(json['data'] is List){
      this.dataList = json['data'];
    }else if(json['data'] is String){
      this.value = json['data'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["code"] = this.code;
    map["msg"] = this.msg;
    map["data"] = this.dataMap;
    return map;
  }
}
