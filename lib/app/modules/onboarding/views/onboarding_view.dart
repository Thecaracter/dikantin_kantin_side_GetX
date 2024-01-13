import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
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
                // checkSharedPreferences();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WillPopScope(
                //       onWillPop: () async => false,
                //       child: Login(),
                //     ),
                //   ),
                // );
                Get.offAllNamed('/login');
              },
              child: const Text("Mulai"),
            ),
          ),
        ],
      ),
    );
  }
}
