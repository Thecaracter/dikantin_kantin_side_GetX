import 'dart:convert';

import 'package:dikantin_o_l_d/app/repository/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RiwayatProvider extends GetConnect {
  Future<http.Response> fetchDataRiwayat({
    String? token,
    String? dateStart,
    String? dateEnd,
  }) async {
    print(dateStart);
    print(dateEnd);
    final response = await http.get(
      Uri.parse(Api.riwayat).replace(
        queryParameters: {
          if (dateStart != null) 'searchFrom': dateStart,
          if (dateEnd != null) 'searchTo': dateEnd,
        },
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}
