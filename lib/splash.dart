import 'package:dikantin/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Boarding(
            title: '',
          ),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200),
            child: Image.asset(
              "assets/logo_dikantin.png",
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
