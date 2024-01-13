class RekapharianProduk {
  List<Data>? data;
  int? data2;
  int? code;
  bool? status;

  RekapharianProduk({this.data, this.data2, this.code, this.status});

  RekapharianProduk.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    data2 = json['data2'];
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    if (data != null) {
      jsonData['data'] = data?.map((v) => v.toJson()).toList();
    }
    jsonData['data2'] = data2;
    jsonData['code'] = code;
    jsonData['status'] = status;
    return jsonData;
  }
}

class Data {
  int? idMenu;
  String? nama;
  int? harga;
  String? totalQty;
  int? totalPendapatan;

  Data(
      {this.idMenu,
      this.nama,
      this.harga,
      this.totalQty,
      this.totalPendapatan});

  Data.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    nama = json['nama'];
    harga = json['harga'];
    totalQty = json['total_qty'];
    totalPendapatan = json['total_pendapatan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_menu'] = idMenu;
    data['nama'] = nama;
    data['harga'] = harga;
    data['total_qty'] = totalQty;
    data['total_pendapatan'] = totalPendapatan;
    return data;
  }
}
