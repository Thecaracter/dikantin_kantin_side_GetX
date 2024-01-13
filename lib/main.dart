import 'dart:io';
import 'package:flutter/services.dart';
import 'package:dikantin_o_l_d/app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  showNotification(flutterLocalNotificationsPlugin, message);
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Inisialisasi FCMService
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(
        () async {
          // final fmcToken = await messaging.getToken();
          // TokenController tokenController = TokenController();
          // tokenController.saveToStorage(fmcToken, 'tokenFirebase');
          // debugPrint(fmcToken);
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          messaging.requestPermission();

          FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) async {
              FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                  FlutterLocalNotificationsPlugin();

              await showNotification(flutterLocalNotificationsPlugin, message);
            },
          );
        },
      ),
    ),
  );
}

showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RemoteMessage message) async {
  print("show notifications");
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('DiPujasKantin', 'DiPujasKantin',
          importance: Importance.max,
          priority: Priority.high,
          silent: false,
          playSound: true,
          icon: "@mipmap/ic_launcher",
          sound: RawResourceAndroidNotificationSound('notif'),
          showWhen: true);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0, // ID notifikasi
    message.notification!.title, // Judul notifikasi dari pesan FCM
    message.notification!.body,
    // Isi notifikasi dari pesan FCM
    platformChannelSpecifics,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
