

import 'package:flutter/material.dart';
import 'package:flutter_base_project/widget/button_primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog{
  final BuildContext context;
  bool isShowing = false;

  CustomDialog(this.context);

  hideDialog(){
    print("showing = ${isShowing}");
    if(isShowing){
      Navigator.pop(context);
      isShowing = false;
    }
  }


  showLoading({bool dismissible = false}) {
    isShowing = true;
    print("showing = ${isShowing}");
    showDialog(
      barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return LoadingDialog();
        }).then((value) {
      isShowing = false;
    });
  }

  success({bool dismissible = false,required String message}) {
    isShowing = true;
    print("showing = ${isShowing}");
    showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message,);
        }).then((value) {
      isShowing = false;
    });
  }


  error({bool dismissible = false, required String message}) {
    isShowing = true;
    print("showing = ${isShowing}");
    showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message);
        }).then((value) {
      isShowing = false;
    });
  }


}


class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        height: 150.h,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Center(
            child: SizedBox(
              height: 80.h,
                width: 80.h,
                child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}


class MessageDialog extends StatelessWidget {
  final String message;
  const MessageDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        height: 200.h,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: message),
              ),
              ButtonPrimary(click: (){

              }, teks: "Test")
            ],
          ),
        ),
      ),
    );
  }
}

