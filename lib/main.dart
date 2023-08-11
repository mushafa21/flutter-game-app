import 'package:flutter/material.dart';
import 'package:flutter_base_project/style/custom_color.dart';
import 'package:flutter_base_project/ui/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /** initialisasi firebase */
  // if (Platform.isIOS) {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // } else{
  //   await Firebase.initializeApp();
  // }

  /** Initialisasi Sharedpref*/
  SharedPreferences prefs = await SharedPreferences.getInstance();
  app.pref = prefs;


  /**Initialisasi package info*/
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  app.packageInfo = packageInfo;



  /**Initialisasi Locale*/
  initializeDateFormatting();

  /** update delay onresume */
  // VisibilityDetectorController.instance.updateInterval = Duration(milliseconds: 250);
  // // Plugin must be initialized before using
  // await FlutterDownloader.initialize(
  //     debug: true, // optional: set to false to disable printing logs to console (default: true)
  //     ignoreSsl: true // option: set to false to disable working with http links (default: false)
  // );


  /** action notifikasi */

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  // FirebaseMessaging.onMessage.listen((message) async {
  //   print(message.toString());
  //   print("data : ${message.data.toString()}");
  //
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails('com.cancreative.ess_ksp', 'Notifikasi',
  //       channelDescription: 'Notifikasi My KSP',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //   const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails();
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iosPlatformChannelSpecifics);
  //
  //   await FlutterLocalNotificationsPlugin().show(
  //       0, 'My KSP', message.notification!.body, platformChannelSpecifics,
  //       payload: message.data["payload"]);
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    /** Init Screen Util Agar Tampilan Responsif*/
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        /** Design Size Bisa Diganti Sesuai Dengan Ukuran Canvas Figma */
        designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Games',
          theme: ThemeData(
            appBarTheme:  AppBarTheme(
              backgroundColor: Colors.white,
              toolbarHeight: 60.h,
              iconTheme: IconThemeData(
                size: 30.r,
                color: CustomColor.dark,
              ),
            ),
            primaryColor: CustomColor.primary500,
            primarySwatch: Colors.blue,
            fontFamily: 'Jakarta',),
          home: const HomeScreen(),
        );
      }
    );
  }
}

