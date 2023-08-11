import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_project/network/response/list_game_response.dart';
import 'package:flutter_base_project/repository/games_repo.dart';

import '../../firebase/firebase_send.dart';
import '../../utils/log.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final GameRepo _repo = GameRepo();

  getGame(int page) async {
    /** Perlu menambahkan delay agar loading muncul */
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        emit(HomeLoading());
        final response = await _repo.listGame(page);
        emit(HomeSuccess(response : response));
      } catch (e) {
        if(e.runtimeType != String){
          emit(const HomeError(error:"Terjadi Kesalahan, Silahkan coba beberapa saat lagi"));
          LogMessage().log(lokasi: "Home", message:e.toString());
          FirebaseSend().send(lokasi: runtimeType.toString(), message: e.toString());
        } else{
          emit(HomeError(error: e.toString()));

        }
      }
    });

  }
}
