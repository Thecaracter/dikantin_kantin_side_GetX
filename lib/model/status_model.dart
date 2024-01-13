class Status {
  String? data;
  int? code;
  bool? status;

  Status({this.data, this.code, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = data;
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}
