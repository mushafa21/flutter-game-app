

import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:ess_ksp/app/app.dart' as app;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// import '../model/error_model.dart';
import '../model/error_model.dart';
import '../utils/helper.dart';

class FirebaseSend{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  void send({required String lokasi,required String message}) async {
    // String date = Helper().getCurrentDate();
    // String time = Helper().getCurrentTime();
    // DatabaseReference ref2 = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://ess-ksp-default-rtdb.asia-southeast1.firebasedatabase.app").ref();
    // var deviceType = "";
    // var deviceInfo = "";
    // var appVersion = app.packageInfo?.version ?? "";
    // if (Platform.isAndroid) {
    //   deviceType = "ANDROID";
    //   var androidInfo = await DeviceInfoPlugin().androidInfo;
    //   var release = androidInfo.version.release;
    //   var sdkInt = androidInfo.version.sdkInt;
    //   var manufacturer = androidInfo.manufacturer;
    //   var model = androidInfo.model;
    //   deviceInfo = 'Android $release (SDK $sdkInt), $manufacturer $model';
    //
    //
    // } else if (Platform.isIOS) {
    //   deviceType = "IOS";
    //   var iosInfo = await DeviceInfoPlugin().iosInfo;
    //   var systemName = iosInfo.systemName;
    //   var version = iosInfo.systemVersion;
    //   var name = iosInfo.name;
    //   var model = iosInfo.model;
    //   deviceInfo = '$systemName $version, $name $model';
    // }
    //
    // ErrorModel errorModel = ErrorModel(namaUser: "",idUser: "",pesan: message, lokasi: lokasi,appVersi: appVersion,device: deviceInfo,waktu: Helper().getCurrentDateTime());
    // await ref2.child("log").child(date).child(time).set(errorModel.toJson());

  }

}