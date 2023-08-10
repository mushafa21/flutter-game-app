

import 'dart:convert';
import 'package:intl/intl.dart';


class Helper{

  int getAge(DateTime today, DateTime dob) {
    final year = today.year - dob.year;
    final mth = today.month - dob.month;
    // final days = today.day - dob.day;
    if(mth < 0){
      /// negative month means it's still upcoming
      return year - 1;
    }
    else {
      return year;
    }
  }

  static void prettyPrintJson(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    encoder.convert(jsonObject).split('\n').forEach((element) => print(element));
  }


  String capitalize(String data){
    return "${data[0].toUpperCase()}${data.substring(1).toLowerCase()}";
  }

  String getCurrentTime(){
    final date = DateTime.now();
    return DateFormat("HH:mm:ss","id").format(date);
  }

  String getCurrentDate({String? format}){
    final date = DateTime.now();
    return DateFormat(format ?? "yyyy-MM-dd","id").format(date);
  }

  String getCurrentDateTime(){
    final date = DateTime.now();
    return DateFormat("yyyy-MM-dd HH:mm","id").format(date);
  }

  String getTimeDifference(DateTime from, DateTime to){

    Duration difference = to.difference(from);


    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return ("$hours hour(s) Of Work");
  }

  String formatJam(String time){
    String p = "";
    String jam = convertDate(tanggal: time,dari: "HH:mm:ss", ke: "HH");
    String menit = convertDate(tanggal: time,dari: "HH:mm:ss", ke: "mm");
    String detik = convertDate(tanggal: time,dari: "HH:mm:ss", ke: "ss");

    if(jam != "00"){
      p += "${jam} jam ";
    }

    if(menit != "00" ){
      p += "${menit} menit ";

    }

    if(detik != "00" ){
      p += "${detik} detik";
    }

    return p;
  }



  int getDifferenceWithoutWeekends(DateTime startDate, DateTime endDate) {
    int nbDays = 0;
    DateTime currentDay = startDate;
    while (currentDay.isBefore(endDate)) {
      currentDay = currentDay.add(Duration(days: 1));
      if (currentDay.weekday != DateTime.saturday && currentDay.weekday != DateTime.sunday) {
        nbDays += 1;
      }
    }
    return nbDays;
  }


  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Pagi';
    }
    if (hour < 17) {
      return 'Siang';
    }
    return 'Sore';
  }

  String convertNomor(String nomor){
    if(nomor.startsWith("0")){
      return nomor.replaceFirst("0", "+62");
    } else{
      return nomor;
    }
  }


  String timeStampToString(String timestamp,{String ke ='dd MMMM yyyy, HH:mm' }){
    try{
      DateTime dt = DateTime.parse(timestamp);
      DateFormat format = DateFormat(ke);
      return format.format(dt);
    } catch(e){
      return timestamp;
    }

  }

  String convertDate({required String tanggal, String dari = "yyyy-MM-dd HH:mm", required String ke}){
    try{
      DateTime tempDate = DateFormat(dari).parse(tanggal);
      return DateFormat(ke,"id").format(tempDate);
    }catch(e){
      return tanggal;
    }

  }



  bool validasiEmail(String email){
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool validasiNomor(String nomor){
    if(nomor.length < 9){
      return false;
    }else{
      return true;
    }
  }


  String dateTimeToString({required DateTime waktu, String format = "yyyy-MM-dd HH:mm:ss"}){
    try{
      return DateFormat(format,"id").format(waktu);
    } catch(e){
      return waktu.toString();
    }
  }

  DateTime stringToDateTime({required String dateString, required String dari}){
    try{
      DateTime tempDate = DateFormat(dari).parse(dateString);
      return tempDate;

    }catch(e){
      return DateTime.now();
    }
  }



  String convertRupiah(int angka) {
    try{
      final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
      return formatCurrency.format(angka);
    } catch(e){
      return angka.toString();
    }

  }

  int daysBetween({required String from, required String to}){
    try{
      final dateFrom = DateFormat("yyyy-MM-dd HH:mm").parse(from);
      final dateTo = DateFormat("yyyy-MM-dd HH:mm").parse(to);
      if ((dateTo.difference(dateFrom).inHours / 24).ceil() == 0){
        return 1;
      } else{
        return (dateTo.difference(dateFrom).inHours / 24).ceil();
      }
    }catch(e){

      return 0;

    }

  }

  int daysBetweenDate({required DateTime from, required DateTime to}){
    try{
      if ((to.difference(from).inHours / 24).ceil() == 0){
        return 1;
      } else{
        return (to.difference(from).inHours / 24).ceil();
      }
    }catch(e){

      return 0;

    }

  }

  int hoursBetween({required String from, required String to}){
    try{
      final dateFrom = DateFormat("yyyy-MM-dd HH:mm").parse(from);
      final dateTo = DateFormat("yyyy-MM-dd HH:mm").parse(to);
      return (dateTo.difference(dateFrom).inMinutes / 60).ceil();
    }catch(e){
      return 0;
    }

  }

  String daysHoursBetween({required String from, required String to}){
    try{
      final dateFrom = DateFormat("yyyy-MM-dd HH:mm").parse(from);
      final dateTo = DateFormat("yyyy-MM-dd HH:mm").parse(to);
      final hari = dateTo.difference(dateFrom).inDays;
      final jam = (dateTo.difference(dateFrom).inMinutes / 60).ceil() % 24;

      return "${hari} hari dan ${jam} jam";
    } catch(e){
      return "error";
    }

  }






}
