class Statistik {
  String? jumlah;
  int? tanggal;

  Statistik({this.jumlah, this.tanggal});

  Statistik.fromJson(Map<String, dynamic> json) {
    jumlah = json['jumlah'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah'] = this.jumlah;
    data['tanggal'] = this.tanggal;
    return data;
  }
}
