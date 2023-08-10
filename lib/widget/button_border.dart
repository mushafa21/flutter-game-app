
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/custom_color.dart';
import '../style/custom_text_style.dart';

class ButtonBorder extends StatelessWidget {
  final Function() click;
  final String teks;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;

  const ButtonBorder({Key? key,required this.click, required this.teks,this.width, this.height,this.color,this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: click,style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
              color: CustomColor.gray100,
              width: 1.w,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(12.r),

        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(width ?? double.infinity, height ?? 55.h)),
      backgroundColor:
      MaterialStateProperty.all(color ?? CustomColor.white),
    ), child : Text(teks, style: CustomTextStyle.semiBold12.copyWith(color: textColor ?? CustomColor.gray400),),);
  }
}