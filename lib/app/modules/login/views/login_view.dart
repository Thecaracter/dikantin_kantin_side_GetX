import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textscalefactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');
    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
      child: Scaffold(
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
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: 'Email@gmail.com',
                                suffixIcon: Icon(
                                  CarbonIcons.user_avatar,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Obx(
                              () => TextField(
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.obscureText.value
                                        ? CarbonIcons.view_off
                                        : CarbonIcons.view),
                                    onPressed: () {
                                      controller.toggleObscureText();
                                    },
                                  ),
                                ),
                                obscureText: controller.obscureText.value,
                              ),
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
                                onPressed: () async {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  String? token =
                                      sharedPreferences.getString('tokenFcm');
                                  print("login clicked");
                                  print("inifcm$token");
                                  controller.login(
                                      controller.emailController.text,
                                      controller.passwordController.text,
                                      token!);
                                },
                                child: const Text("Login"),
                              ),
                            ),
                            SizedBox(height: 20),
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
