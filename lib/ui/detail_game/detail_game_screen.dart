import 'package:flutter/material.dart';
import 'package:flutter_base_project/model/game_model.dart';
import 'package:flutter_base_project/style/custom_text_style.dart';
import 'package:flutter_base_project/ui/detail_game/detail_game_cubit.dart';
import 'package:flutter_base_project/utils/custom_dialog.dart';
import 'package:flutter_base_project/widget/image_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailGameScreen extends StatefulWidget {
  final GameModel data;

  const DetailGameScreen({super.key, required this.data});

  @override
  State<DetailGameScreen> createState() => _DetailGameScreenState();
}

class _DetailGameScreenState extends State<DetailGameScreen> {
  GameModel? dataGame;
  CustomDialog? dialog;
  DetailGameCubit? cubit;

  @override
  Widget build(BuildContext context) {
    dialog ??= CustomDialog(context);
    return BlocProvider(
      create: (context) => DetailGameCubit()..detailGame(widget.data.id ?? 0),
      child: BlocConsumer<DetailGameCubit, DetailGameState>(
        listener: (context, state) {
          if(state is DetailGameLoading){
            dialog?.hideDialog();
            dialog?.showLoading();
          } else if(state is DetailGameSuccess){
            dialog?.hideDialog();
            dataGame = state.response;

          } else if(state is DetailGameError){
            dialog?.hideDialog();
            dialog?.error(message: state.error);

          }
        },
        builder: (context, state) {

          cubit ??= BlocProvider.of<DetailGameCubit>(context);
          AppBar appBar(){
            return AppBar(
              title: Text("Detail Game",style: CustomTextStyle.semiBold14,),
            );
          }


          Widget viewImage(){
            return ImageView(url: dataGame?.backgroundImage ?? "");
          }

          Widget viewData(){
            return Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                children: [
                  Text(dataGame?.name ?? "",style: CustomTextStyle.semiBold14,),
                  SizedBox(height: 10.h,),
                  Text(dataGame?.released ?? "",style: CustomTextStyle.reguler12,),
                ],
              ),
            );
          }

          Widget viewMain(){
            return RefreshIndicator(
              onRefresh: () {
                cubit?.detailGame(widget.data.id ?? 0);
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    viewImage(),
                    viewData(),

                  ],
                ),
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              appBar: appBar(),
              body: viewMain(),
            ),
          );
        },
      ),
    );
  }
}
