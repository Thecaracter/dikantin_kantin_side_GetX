import 'dart:async';
import 'package:dikantin/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeService();
  runApp(const MyApp());
}

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();

//   /// OPTIONAL, using custom notification channel id
//   // const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   //   'my_foreground', // id
//   //   'MY FOREGROUND SERVICE', // title
//   //   description:
//   //       'This channel is used for important notifications.', // description
//   //   importance: Importance.low, // importance must be at low or higher level
//   // );

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (Platform.isIOS) {
//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//           // iOS: IOSInitializationSettings(),
//           ),
//     );
//   }

//   // await flutterLocalNotificationsPlugin
//   //     .resolvePlatformSpecificImplementation<
//   //         AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel(channel);

//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,

//       // notificationChannelId: 'my_foreground',
//       // initialNotificationTitle: 'AWESOME SERVICE',
//       // initialNotificationContent: 'Initializing',
//       // foregroundServiceNotificationId: 888,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,

//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,

//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );

//   service.startService();
// }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.reload();
//   final log = preferences.getStringList('log') ?? <String>[];
//   log.add(DateTime.now().toIso8601String());
//   await preferences.setStringList('log', log);

//   return true;
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();

//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually

//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setString("hello", "world");

//   /// OPTIONAL when use custom notification
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   // String? _idKantin;
//   // final prefs = await SharedPreferences.getInstance();

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     String? _idKantin;
//     dynamic prefs = await SharedPreferences.getInstance();
//     _idKantin = prefs.getString('id_kantin');

//     if (_idKantin == null) {
//       _idKantin = "0";
//       await Login();
//       _idKantin = prefs.getString('id_kantin');
//     } else {
//       _idKantin = _idKantin;
//     }
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         final appKey = "9e19e751bd7616c25541";
//         final secret = "15f79358c7b376e05d79";
//         final cluster = "ap1";

// // Inisialisasi PusherClient
//         PusherClient pusher = PusherClient(
//             appKey,
//             PusherOptions(
//               cluster: cluster,
//               encrypted: true,
//             ));

// // Subscribe ke channel "my-channel"
//         // Channel channel = pusher.subscribe("2");
//         Channel channel = pusher.subscribe(_idKantin!);

// // Bind event "my-event"
//         channel.bind(_idKantin!, (event) async {
//           // Tampilkan data event di terminal
//           print(event?.data);

//           // Menampilkan notifikasi lokal
//           FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//               FlutterLocalNotificationsPlugin();
//           const AndroidInitializationSettings initializationSettingsAndroid =
//               AndroidInitializationSettings('@mipmap/logo');
//           final InitializationSettings initializationSettings =
//               InitializationSettings(
//             android: initializationSettingsAndroid,
//           );
//           await flutterLocalNotificationsPlugin
//               .initialize(initializationSettings);

//           const AndroidNotificationDetails androidPlatformChannelSpecifics =
//               AndroidNotificationDetails(
//             'channel_id',
//             'channel_name',
//             channelDescription: 'deskripsi channel',
//             importance: Importance.max,
//             priority: Priority.high,
//             playSound: true,
//             enableVibration: true,
//             enableLights: true,
//             ledColor: Colors.green,
//             ledOnMs: 1000,
//             ledOffMs: 500,
//             icon: '@mipmap/polije',
//           );

//           const NotificationDetails platformChannelSpecifics =
//               NotificationDetails(android: androidPlatformChannelSpecifics);
//           await flutterLocalNotificationsPlugin.show(
//               0,
//               'DIKANTIN POLIJE',
//               "Ada Pesanan,Silahkan Klik untuk melihat" ?? 'Tidak ada data',
//               platformChannelSpecifics);
//         });

// // Connect PusherClient
//         await pusher.connect();
//         // await pusher.unsubscribe('2');
//       }
//     }

//     /// you can see this log in logcat
//     // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }

//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class LogView extends StatefulWidget {
  const LogView({Key? key}) : super(key: key);

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  late final Timer timer;
  List<String> logs = [];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.reload();
      logs = sp.getStringList('log') ?? [];
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs.elementAt(index);
        return Text(log);
      },
    );
  }
}
