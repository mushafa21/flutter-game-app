
import 'package:flutter_base_project/model/game_model.dart';
import 'package:flutter_base_project/network/response/list_game_response.dart';

import '../network/api_helper.dart';

class GameRepo{
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ListGameResponse> listGame(int page) async {
    final response = await _helper.get(url: "games",parameter: {
      "page" : page,
      "page_size" : 10
    });
    return ListGameResponse.fromJson(response);
  }

  Future<GameModel> detailGame(int id) async {
    final response = await _helper.get(url: "games/$id");
    return GameModel.fromJson(response);
  }

}