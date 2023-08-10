import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

/** key value */
const String first_key = "first";
const String login_key = "login";
const String user_key = "user";
const String token_key = "token";



SharedPreferences? pref;
PackageInfo? packageInfo;

/** global var */
bool showPopUp = true;


/** package info */
String appName = packageInfo!.appName;
String packageName = packageInfo!.packageName;
String version = packageInfo!.version;
String buildNumber = packageInfo!.buildNumber;

/** Shared Prefs */
String username = pref?.getString(user_key) ?? "";
bool status_login = pref?.getBool(login_key) ?? false;





setStatusLogin(bool status) async {
  await pref?.setBool(login_key, status);
}

setPertama(bool status) async {
  await pref?.setBool(first_key, status);
}

bool getPertama(){
  return pref?.getBool(first_key) ?? true;
}






setUsername(String name) async {
  await pref?.setString(user_key, name);
}



setToken(String newToken) async {
  await pref?.setString(token_key, newToken);
}

String getToken(){
  return pref?.getString(token_key) ?? "";
}

setUser(UserModel data) async {
  await pref?.setString(user_key, json.encode(data.toJson()));
}

UserModel getUser() {
  if (pref?.getString(user_key) != null) {
    try {
      return UserModel.fromJson(json.decode(pref?.getString(user_key) ?? ""));
    } catch (e) {
      print(e.toString());
      return UserModel();
    }
  } else {
    print("STRING NULL");
    return UserModel();
  }
}



clearData() {
  pref?.clear();
  setPertama(false);
  // user = UserModel();
}