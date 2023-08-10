
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/custom_color.dart';
import '../style/custom_text_style.dart';

class ButtonPrimary extends StatelessWidget {
  final Function() click;
  final String teks;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final bool active;
  final TextStyle? textStyle;


  const ButtonPrimary({Key? key,required this.click, required this.teks,this.width, this.height,this.color,this.textColor, this.active = true, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: click,style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(width ?? double.infinity, height ?? 55.h)),
      backgroundColor:
      MaterialStateProperty.all(active ? color ?? CustomColor.primary500 : CustomColor.gray100),
    ), child : Text(teks, style: textStyle ?? CustomTextStyle.semiBold12.copyWith(color: textColor ?? (active ? CustomColor.white:CustomColor.gray500)),),);
  }
}