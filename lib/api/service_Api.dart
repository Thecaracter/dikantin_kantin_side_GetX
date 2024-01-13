import 'dart:convert';
import 'package:dikantin/main.dart';
import 'package:dikantin/model/Laporan_model.dart';
import 'package:dikantin/model/Statistik.dart';
import 'package:dikantin/model/Penghasilan_bulanan.dart';
import 'package:dikantin/model/Penjualan_mode.dart';
import 'package:dikantin/model/Riwayat_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dikantin/model/Menu_model.dart';
import 'package:dikantin/model/User_model.dart';

class AuthService extends GetxController {
  static const String apiUrl = 'http://dikantin.com/api/validate/loginKantin';

  Future<void> login(String emailOrUsername, String password, String fcm) async {
    try {
      String email = "";
      String username = "";
      if (emailOrUsername.contains("@gmail.com")) {
        email = emailOrUsername;
      } else {
        username = emailOrUsername;
      }
      final response = await http.post(Uri.parse(apiUrl), body: {
        'email': email,
        'username': username,
        'password': password,
        'fcm_token': fcm,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('user')) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              'user_token',
              json.encode(data['user']['username'],
                  toEncodable: (value) => value.toString()));
          prefs.setString(
              'email_token',
              json.encode(data['user']['email'],
                  toEncodable: (value) => value.toString()));
          prefs.setString(
              'id_kantin',
              json.encode(data['user']['id_kantin'],
                  toEncodable: (value) => value.toString()));
          prefs.setString(
              'foto',
              json.encode(data['user']['foto'],
                  toEncodable: (value) => value.toString()));
          prefs.setString(
              'id_user',
              json.encode(data['user']['id'],
                  toEncodable: (value) => value.toString()));
        } else if (data.containsKey('error')) {
          throw Exception(data['error']);
        } else {
          throw Exception('Gagal login');
        }
      } else {
        throw Exception('Gagal login');
      }
    } catch (e) {
      throw Exception('Gagal login');
    }
  }

 
}

class ServiceApi {
  String? _idKantin;
  Future<List<MenuApi>> getMenu() async {
    final prefs = await SharedPreferences.getInstance();

    _idKantin = prefs.getString('id_kantin');

    final response = await http.post(
      Uri.parse('http://dikantin.com/api/menu/apimenu'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => MenuApi.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching menu');
    }
  }
}

class ServiceApiPenjualan {
  String? _idKantin;
  Future<List<ModelPenjualan>> getPenjualan() async {
    final prefs = await SharedPreferences.getInstance();

    _idKantin = prefs.getString('id_kantin');

    final response = await http.post(
      Uri.parse('http://dikantin.com/api/transaction/listOrderKantin'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ModelPenjualan.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching menu');
    }
  }
}

class ServiceApiRiwayat {
  String? _idKantin;
  Future<List<ModelRiwayat>> getriwayat() async {
    final prefs = await SharedPreferences.getInstance();

    _idKantin = prefs.getString('id_kantin');

    final response = await http.post(
      Uri.parse('http://dikantin.com/api/api-riwayat'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ModelRiwayat.fromJson(e)).toList();
    } else {
      throw Exception('Error fetching menu');
    }
  }
}

class UpdatePenjualanService {
  Future<void> updateStatusPenjualan(
      String idDetail, kode, idKantin, kodeMenu) async {
    final url =
        Uri.parse('http://dikantin.com/api/transaction/konfirmasiPesanan');
    final response = await http.post(
      url,
      body: {
        'kode_tr': idDetail,
        'kode': kode,
        'kantin': idKantin,
        'kode_menu': kodeMenu
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status penjualan');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status penjualan');
    }
  }
}

class UpdateHabisService {
  Future<void> updatehabis(String id) async {
    final url = Uri.parse('http://dikantin.com/api/updatehabis');
    final response = await http.post(
      url,
      body: {
        'id_menu': id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status penjualan');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status penjualan');
    }
  }
}

class UpdateAdaService {
  Future<void> updateada(String id) async {
    final url = Uri.parse('http://dikantin.com/api/updateada');
    final response = await http.post(
      url,
      body: {
        'id_menu': id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status penjualan');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status penjualan');
    }
  }
}

class ServiceApiSuccesDate {
  String? _idKantin;
  Future<int> getsuccesdate() async {
    final prefs = await SharedPreferences.getInstance();

    _idKantin = prefs.getString('id_kantin');

    final response = await http.post(
      Uri.parse('http://dikantin.com/api/apisucces-date'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return int.parse(jsonResponse['data']);
    } else {
      throw Exception('Error fetching menu');
    }
  }
}

class ServiceApiProsessDate {
  String? _idKantin;
  Future<int> getprosesdate() async {
    final prefs = await SharedPreferences.getInstance();

    _idKantin = prefs.getString('id_kantin');

    final response = await http.post(
      Uri.parse('http://dikantin.com/api/apiproses-date'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return int.parse(jsonResponse['data']);
    } else {
      throw Exception('Error fetching menu');
    }
  }
}

class ServiceApiJumlahPenjualanBulanIni {
  String? _idKantin;
  Future<int> getJumlahPenjualanBulanIni(String idKantin) async {
    final prefs = await SharedPreferences.getInstance();
    _idKantin = prefs.getString('id_kantin');
    final response = await http.post(
      Uri.parse('http://dikantin.com/api/hargabulanan'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return int.parse(jsonResponse['jumlah_penjualan']);
    } else {
      throw Exception('Error fetching data');
    }
  }
}

class ServiceApiJumlahPenjualanHariIni {
  String? _idKantin;
  Future<int> getJumlahPenjualanHariIni(String idKantin) async {
    final prefs = await SharedPreferences.getInstance();
    _idKantin = prefs.getString('id_kantin');
    final response = await http.post(
      Uri.parse('http://dikantin.com/api/hargaharian'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return int.parse(jsonResponse['jumlah_penjualan']);
    } else {
      throw Exception('Error fetching data');
    }
  }
}

class StatistikService {
  String? _idKantin;

  Future<List<Statistik>> getStatistik(String s) async {
    final prefs = await SharedPreferences.getInstance();
    _idKantin = prefs.getString('id_kantin');
    final response = await http.post(
      Uri.parse('http://dikantin.com/api/statistik'),
      body: {'id_kantin': _idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((item) => Statistik.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class UserProfile {
  String? _idUser;

  Future<userGet> getUserProfile(String s) async {
    final prefs = await SharedPreferences.getInstance();
    _idUser = prefs.getString('id_user');
    try {
      final response = await http.post(
        Uri.parse('http://dikantin.com/api/validate/userprofile'),
        body: {'id': _idUser?.toString() ?? ''},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return userGet.fromJson(data);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

class Laporan_Service {
  Future<List<LaporanModel>> getRentangPendapatan(
      String startDate, String endDate) async {
    final prefs = await SharedPreferences.getInstance();
    final String? _idKantin = prefs.getString('id_kantin');
    final String apiUrl = 'http://dikantin.com/api/rentangpendapatan';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'tanggalMulai': startDate,
        'tanggalSelesai': endDate,
        'id_kantin': _idKantin,
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<LaporanModel> data =
            responseData.map((e) => LaporanModel.fromJson(e)).toList();
        return data;
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data. Error: $e');
    }
  }
}
