import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_project/model/game_model.dart';

import '../../firebase/firebase_send.dart';
import '../../repository/games_repo.dart';
import '../../utils/log.dart';

part 'detail_game_state.dart';

class DetailGameCubit extends Cubit<DetailGameState> {
  DetailGameCubit() : super(DetailGameInitial());
  final GameRepo _repo = GameRepo();

  detailGame(int id) async {
    /** Perlu menambahkan delay agar loading muncul */
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        emit(DetailGameLoading());
        final response = await _repo.detailGame(id);
        emit(DetailGameSuccess(response : response));
      } catch (e) {
        if(e.runtimeType != String){
          emit(const DetailGameError(error:"Terjadi Kesalahan, Silahkan coba beberapa saat lagi"));
          LogMessage().log(lokasi: "DetailGame", message:e.toString());
          FirebaseSend().send(lokasi: runtimeType.toString(), message: e.toString());
        } else{
          emit(DetailGameError(error: e.toString()));

        }
      }
    });

  }
}
