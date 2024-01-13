import 'dart:convert';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/api/modal_update_profile.dart';
import 'package:dikantin/api/service_Api.dart';
import 'package:dikantin/login.dart';
import 'package:dikantin/model/Menu_model.dart';
import 'package:dikantin/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ServiceApi api = ServiceApi();
  UserProfile _userProfile = UserProfile();
  late Future<userGet> listdata;
  @override
  String? _kantin;
  String? _name;
  String? _email;
  String? _foto;
  void initState() {
    super.initState();
    _getToken();
    _loadUserProfile();
  }

  void clears() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> logout() async {
    // Hapus data dari SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigasi ke halaman login
    Get.offAll(Login());
  }

  Future<void> _loadUserProfile() async {
    final userProfile = await _userProfile.getUserProfile('');
    setState(() {
      _foto = userProfile.foto;
      _name = userProfile.username;
      _email = userProfile.email;
    });
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email_token');
      _kantin = prefs.getString('id_kantin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadUserProfile,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Group_14.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width / 500,
                right: MediaQuery.of(context).size.width / 500,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text("PROFIL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(60.0),
                        border: Border.all(width: 2.0, color: Colors.blue),
                      ),
                      child: ClipOval(
                        child: _foto != null
                            ? Image.network(
                                "http://dikantin.com/" +
                                    _foto!.replaceAll('"', ''),
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _name?.replaceAll('"', '') ?? '',
                      style: TextStyle(
                          color: Color(0xffedf4f6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _email?.replaceAll('"', '') ?? '',
                      style: TextStyle(
                          color: Color(0xffedf4f6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.4),
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffedf3f6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(4, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                          Container(
                            height: 55,
                            width: 295,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  offset: Offset(4, 4),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CarbonIcons.user_avatar,
                                  color: Colors.black,
                                ),
                              ),
                              title: Container(
                                child: Text(
                                  "Ubah Akun",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              trailing: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  // color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    CarbonIcons.play_outline_filled,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    await ModalService.showModal(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Image.asset(
                                      "assets/Tanya.png",
                                      width: 64.0,
                                      height: 64.0,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: Text(
                                          "Anda Akan Logout ?",
                                          style: TextStyle(
                                            color: Color(0xff3CA2D9),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('Ya'),
                                              onPressed: () async {
                                                await logout();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('Tidak'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 55,
                              width: 295,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(4, 4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    CarbonIcons.logout,
                                    color: Colors.red,
                                  ),
                                ),
                                title: Container(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.red),
                                  ),
                                ),
                                trailing: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.7,
                left: MediaQuery.of(context).size.width / 500,
                right: MediaQuery.of(context).size.width / 500,
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(4, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 14, left: 10),
                                  child: Image.asset(
                                    "assets/Vector.png",
                                    height: 50,
                                    width: 100,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2,
                                    right: MediaQuery.of(context).size.width *
                                        0.01, // menggunakan persentase dari lebar layar
                                    left: MediaQuery.of(context).size.width *
                                        0.05, // menggunakan persentase dari lebar layar
                                  ),
                                  child: Text(
                                    "Total Menu",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                              width: 20,
                              thickness: 1,
                              color: Color(0xff514D4E)),
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<List<MenuApi>>(
                              future: api.getMenu(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(' ${snapshot.data!.length}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 50.0,
                                        )),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text("Not found");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
