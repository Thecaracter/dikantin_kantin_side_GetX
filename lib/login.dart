import 'dart:convert';
import 'package:dikantin/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin/bottom_navigation.dart';
import 'package:dikantin/register.dart';
import 'package:get/get.dart';

import 'api/service_Api.dart';
import 'controller/controller_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginKantinController loginKantinController =
      Get.put(LoginKantinController());

  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Future<void> _handleLogin() async {
  //   String emailOrUsername = emailController.text;
  //   String password = passwordController.text;
  //   AuthService authService = AuthService();
  //   print("klik");
  //   try {
  //     await authService.login(emailOrUsername, password);
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Navigation(),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Row(
  //           children: [
  //             Icon(
  //               Icons.close,
  //               color: Colors.white,
  //               size: 40,
  //             ),
  //             Text(
  //               e.toString(),
  //               style: TextStyle(fontSize: 8),
  //             ),
  //           ],
  //         ),
  //         duration: Duration(seconds: 5),
  //         behavior: SnackBarBehavior.floating,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //           side: BorderSide(color: Colors.red, width: 2.0),
  //         ),
  //         backgroundColor: Colors.red,
  //         elevation: 5.0,
  //         margin: EdgeInsets.all(10.0),
  //         padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  //         action: SnackBarAction(
  //           label: 'Dismiss',
  //           textColor: Colors.white,
  //           onPressed: () {
  //             ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //           },
  //         ),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/Maskgroup.png",
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                        color: Color.fromARGB(255, 247, 242, 242),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(4, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text("Masuk Ke Akun Anda"),
                          SizedBox(height: 20),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Email@gmail.com',
                              suffixIcon: Icon(
                                CarbonIcons.user_avatar,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? CarbonIcons.view_off
                                    : CarbonIcons.view),
                                onPressed: _toggleVisibility,
                              ),
                            ),
                            obscureText: _obscureText,
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: 400,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 55, 156, 211),
                              ),
                              onPressed: () {
                                loginKantinController.login(
                                    emailController.text,
                                    passwordController.text,
                                    "dsddasjgdhgashgdh");
                              },
                              child: const Text("Login"),
                            ),
                          ),
                          SizedBox(height: 20),
                          // SizedBox(
                          //   width: 400,
                          //   height: 40,
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(30.0),
                          //         ),
                          //         backgroundColor: Colors.white),
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => Register(),
                          //         ),
                          //       );
                          //     },
                          //     child: const Text(
                          //       "Register",
                          //       style: const TextStyle(
                          //         color: Colors.black54,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text("Forgot Password?"),
                          // ),
                          // SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
