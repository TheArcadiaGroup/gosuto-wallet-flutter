class ServerResponseModel {
  ServerResponseModel({this.data});

  dynamic data;
  int? pageCount;
  int? itemCount;

  ServerResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    pageCount = json['pageCount'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['data'] = data;
    result['pageCount'] = pageCount;
    result['itemCount'] = itemCount;
    return result;
  }
}
