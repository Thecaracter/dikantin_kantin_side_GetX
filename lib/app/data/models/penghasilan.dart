class Penghasilan {
  Data? data;
  int? code;
  bool? status;

  Penghasilan({this.data, this.code, this.status});

  Penghasilan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  int? penjualanBulanIni;
  int? penjualanHariIni;

  Data({this.penjualanBulanIni, this.penjualanHariIni});

  Data.fromJson(Map<String, dynamic> json) {
    penjualanBulanIni = json['penjualanBulanIni'];
    penjualanHariIni = json['penjualanHariIni'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['penjualanBulanIni'] = penjualanBulanIni;
    data['penjualanHariIni'] = penjualanHariIni;
    return data;
  }
}
