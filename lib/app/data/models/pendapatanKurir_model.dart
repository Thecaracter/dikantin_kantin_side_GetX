class PendapatanKurir {
  bool? status;
  String? message;
  DataPendapatanKurir? data;

  PendapatanKurir({
    this.status,
    this.message,
    this.data,
  });

  factory PendapatanKurir.fromJson(Map<String, dynamic> json) {
    return PendapatanKurir(
      status: json['status'],
      message: json['message'],
      data: DataPendapatanKurir.fromJson(json['data']),
    );
  }
}

class DataPendapatanKurir {
  int? month;
  int? today;

  DataPendapatanKurir({
    this.month,
    this.today,
  });

  factory DataPendapatanKurir.fromJson(Map<String, dynamic> json) {
    return DataPendapatanKurir(
      month: json['month'],
      today: json['today'],
    );
  }
}
