class Count {
  Data? data;
  int? code;
  bool? status;

  Count({this.data, this.code, this.status});

  Count.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? selesai;
  int? dilayani;
  int? statusKantin;

  Data({this.selesai, this.dilayani, this.statusKantin});

  Data.fromJson(Map<String, dynamic> json) {
    selesai = json['selesai'];
    dilayani = json['dilayani'];
    statusKantin = json['statusKantin']; // Adjusted this line
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['selesai'] = this.selesai;
    data['dilayani'] = this.dilayani;
    data['statusKantin'] = this.statusKantin; // Adjusted this line
    return data;
  }
}
