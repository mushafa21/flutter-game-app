import 'package:flutter/material.dart';
import 'package:flutter_base_project/model/game_model.dart';
import 'package:flutter_base_project/style/custom_color.dart';
import 'package:flutter_base_project/style/custom_text_style.dart';
import 'package:flutter_base_project/ui/detail_game/detail_game_screen.dart';
import 'package:flutter_base_project/widget/image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/go.dart';


class GameItem extends StatelessWidget {
  final GameModel data;
  const GameItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (){
      //   Go().move(context: context, target: DetailGameScreen(data: data));
      // },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColor.gray400,),
          borderRadius: BorderRadius.circular(10.w)
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            ImageView(url: data.backgroundImage ?? "",width: 50.w,height: 50.w,fit: BoxFit.cover,),
            SizedBox(width: 10.w,),
            Expanded(child: Text(data.name ?? "",style: CustomTextStyle.semiBold12,))
          ],
        ),
      ),
    );
  }
}
