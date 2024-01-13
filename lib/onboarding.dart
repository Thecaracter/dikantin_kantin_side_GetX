import 'package:dikantin/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:dikantin/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Boarding extends StatefulWidget {
  const Boarding({super.key, required String title});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  Future<void> checkSharedPreferences() async {
    String? _idKantin;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _idKantin = prefs.getString('id_kantin');
    // ignore: unnecessary_null_comparison
    if (_idKantin == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: Login(),
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: Navigation(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4EB2E7), Color(0xFFD9D9D9)]),
      ),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Image.asset(
            "assets/onboarding1.png",
            width: MediaQuery.of(context).size.width * 3,
            height: MediaQuery.of(context).size.height * 0.7,
          ),
          Text(
            "WELCOME TO DIKANTIN",
            style: GoogleFonts.inter(
                decoration: TextDecoration.none,
                color: Color(0xff1A2F35),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Cari Makan Tinggal Pesan, Mau Jajan Tinggal Tekan",
              style: GoogleFonts.inter(
                  decoration: TextDecoration.none,
                  color: Color(0xff514d4e),
                  fontSize: 12)),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 320,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4EB2E7),
              ),
              onPressed: () {
                checkSharedPreferences();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WillPopScope(
                //       onWillPop: () async => false,
                //       child: Login(),
                //     ),
                //   ),
                // );
              },
              child: const Text("Mulai"),
            ),
          ),
        ],
      ),
    );
  }
}
