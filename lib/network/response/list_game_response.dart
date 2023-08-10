

import '../../model/game_model.dart';

class ListGameResponse {
  int? count;
  String? next;
  List<GameModel>? results;


  ListGameResponse(
      {this.count,
        this.next,
        this.results,});

  ListGameResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    if (json['results'] != null) {
      results = <GameModel>[];
      json['results'].forEach((v) {
        results!.add(new GameModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}