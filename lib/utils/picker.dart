

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/custom_dialog.dart';
import 'package:flutter_base_project/utils/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../style/custom_color.dart';
import '../style/custom_text_style.dart';
import 'helper.dart';

class Picker{
  /** Media Picker */
  final imagePicker = ImagePicker();
  showImageChoices({required BuildContext context,required Function(File?) callback,bool crop = false}) async {
    if(await PermissionHandler().askPermission(media : true)){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(15.w),
                color: CustomColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: CustomColor.gray400,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Pilih Pengambilan Gambar",
                      style: CustomTextStyle.bold18,
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        child: ListTile(
                          onTap: () async {
                            Navigator.pop(context);
                            callback(await pickImage(context: context,camera: true ));
                          },
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.camera, color: CustomColor.primary500),
                          title: Text("Kamera",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          callback(await pickImage(context: context,camera: false,));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.solidFolderOpen, color: CustomColor.primary500),
                          title: Text("Galeri",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else{
      CustomDialog(context).message(message: "Silahkan Berikan Izin Aplikasi Untuk Mengambil Gambar",onTap: (){
        showImageChoices(context: context, callback: callback,crop: crop);
      });
    }


  }
  Future<File?> pickImage({bool camera = false, required BuildContext context}) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery,maxHeight: 1200, maxWidth: 1200,);
      if(pickedFile != null){
        return File(pickedFile.path);
      } else{
        return null;
      }
    } catch (e) {


    }
  }
  
  /** Date / Time Picker */
  Future<DateTime?> selectDate(BuildContext context, DateTime dateTime,
      {DateTime? startDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate ?? dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: startDate ?? DateTime(1940),
        lastDate: DateTime(2101));
    return picked;
  }

  Future<DateTime?> selectMonthYear(BuildContext context, DateTime dateTime,DateTime? firstDate, DateTime? lastDate) async {
    return await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: firstDate ?? DateTime(2019),
      lastDate: lastDate ?? DateTime(2023),
    );
  }

  selectYear(BuildContext context, Function(String) callback) async {
    await showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          // Changing default contentPadding to make the content looks better

          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: size.height / 3,
            width: size.width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 20 years starting from now
                // Change it depending on your needs.
                ...List.generate(
                  20,
                      (index) => InkWell(
                    onTap: () {
                      // The action you want to happen when you select the year below,
                      callback((int.parse(Helper().dateTimeToString(waktu: DateTime.now(),format: "yyyy")) - index).toString());
                      // Quitting the dialog through navigator.
                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Chip(
                        label: Container(
                          padding: EdgeInsets.all(5.w),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (int.parse(Helper().dateTimeToString(waktu: DateTime.now(),format: "yyyy")) - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context, TimeOfDay timeOfDay) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: timeOfDay,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    return picked;
  }

  Future<DateTime?> selectDateTime(BuildContext context,DateTime dateTime) async {
    final date = await selectDate(context, dateTime);
    if(date == null){
      return null;
    }

    final timeOfDay = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    final time = await selectTime(context, timeOfDay);
    if(time == null){
      return null;
    }

    return DateTime(date.year,date.month,date.day,time.hour,time.minute);

  }
}