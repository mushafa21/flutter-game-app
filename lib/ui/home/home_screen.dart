import 'package:flutter/material.dart';
import 'package:flutter_base_project/ui/home/home_cubit.dart';
import 'package:flutter_base_project/ui/home/widget/game_item.dart';
import 'package:flutter_base_project/utils/custom_dialog.dart';
import 'package:flutter_base_project/widget/button_primary.dart';
import 'package:flutter_base_project/widget/view_kosong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/game_model.dart';
import '../../utils/go.dart';
import '../detail_game/detail_game_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomDialog? dialog;
  HomeCubit? cubit;

  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int itemPerPage = 10;
  bool endPage = false;
  bool isLoading = false;



  List<GameModel> listGame = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading && !endPage) {
          isLoading = !isLoading;
          page += 1;
          cubit?.getGame(page);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    dialog ??= CustomDialog(context);
    return BlocProvider(
      create: (context) => HomeCubit()..getGame(1),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeLoading){
            isLoading = false;
            dialog?.dismiss();
            dialog?.showLoading();
          } else if(state is HomeSuccess){
            isLoading = false;
            dialog?.dismiss();
            if(page ==1){
              listGame = state.response.results ?? [];

            } else{
              listGame.addAll(state.response.results ?? []);
            }
            if ((state.response.results?.length ?? 0) < itemPerPage){
              endPage = true;
            }

          } else if(state is HomeError){
            isLoading = false;
            dialog?.dismiss();
            dialog?.error(message: state.error);

          }

        },
        builder: (context, state) {
          cubit ??= BlocProvider.of<HomeCubit>(context);

          Widget listViewGame(){
            if(listGame.isEmpty){
              return ViewKosong();
            } else{
              return ListView.builder(itemBuilder: (context,index){
                return InkWell(
                    onTap: (){
                      Go().move(context: context, target: DetailGameScreen(data: listGame[index]));
                    },child: GameItem(data: listGame[index]));
              },physics: NeverScrollableScrollPhysics(),itemCount: listGame.length,shrinkWrap: true,);
            }

          }

          Widget viewMain(){
            return RefreshIndicator(
              onRefresh: () {
                page = 1;
                cubit?.getGame(page);
                return Future.value();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      listViewGame()
                    ],
                  ),
                ),
              ),
            );
          }


          return Scaffold(
            body: SafeArea(child: viewMain()),
          );
        },
      ),
    );
  }
}
