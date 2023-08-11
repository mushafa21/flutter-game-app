

import 'package:flutter/material.dart';
import 'package:flutter_base_project/style/custom_color.dart';
import 'package:flutter_base_project/style/custom_text_style.dart';
import 'package:flutter_base_project/widget/button_primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog{
  final BuildContext context;
  bool isShowing = false;

  CustomDialog(this.context);

  dismiss(){
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

  message({required String message, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message,onTap: onTap,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }


  choice({required String message, bool exit = false, Function()? onExit,String? confirmButtonText,String? cancelButtonText, bool dismissible = true, Function()? onTap}) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return ChoiceDialog(message: message,onTap: onTap,confirmButtonText: confirmButtonText,cancelButtonText: cancelButtonText,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }

  success({required String message, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message,onTap: onTap,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }


  error({required String message, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message,onTap: onTap,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
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
  final Function()? onTap;
  const MessageDialog({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        // height: 200.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message,style: CustomTextStyle.semiBold12,),
              SizedBox(height: 10.h,),
              ButtonPrimary(click: (){
                Navigator.pop(context);
                if(onTap != null){
                  onTap!();
                }

              }, teks: "Ok")
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceDialog extends StatelessWidget {
  final String? confirmButtonText;
  final String? cancelButtonText;
  final String message;
  final Function()? onTap;
  const ChoiceDialog({super.key, required this.message, this.onTap, this.confirmButtonText, this.cancelButtonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        // height: 200.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message,style: CustomTextStyle.semiBold12,),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(click: (){
                      Navigator.pop(context);

                    }, teks: cancelButtonText ?? "Batalkan",color: CustomColor.error500,),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: ButtonPrimary(click: (){
                      Navigator.pop(context);
                      if(onTap != null){
                        onTap!();
                      }

                    }, teks: confirmButtonText ?? "Ok"),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

