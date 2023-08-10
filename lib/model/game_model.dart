

class GameModel {
  int? id;
  String? slug;
  String? name;
  String? released;
  bool? tba;
  String? backgroundImage;
  double? rating;
  int? ratingTop;
  int? ratingsCount;
  int? reviewsTextCount;
  int? added;
  int? metacritic;
  int? playtime;
  int? suggestionsCount;
  String? updated;
  int? reviewsCount;
  String? saturatedColor;
  String? dominantColor;

  GameModel(
      {this.id,
        this.slug,
        this.name,
        this.released,
        this.tba,
        this.backgroundImage,
        this.rating,
        this.ratingTop,
        this.ratingsCount,
        this.reviewsTextCount,
        this.added,
        this.metacritic,
        this.playtime,
        this.suggestionsCount,
        this.updated,
        this.reviewsCount,
        this.saturatedColor,
        this.dominantColor,
      });

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    released = json['released'];
    tba = json['tba'];
    backgroundImage = json['background_image'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
    ratingsCount = json['ratings_count'];
    reviewsTextCount = json['reviews_text_count'];
    added = json['added'];
    metacritic = json['metacritic'];
    playtime = json['playtime'];
    suggestionsCount = json['suggestions_count'];
    updated = json['updated'];
    reviewsCount = json['reviews_count'];
    saturatedColor = json['saturated_color'];
    dominantColor = json['dominant_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['released'] = this.released;
    data['tba'] = this.tba;
    data['background_image'] = this.backgroundImage;
    data['rating'] = this.rating;
    data['rating_top'] = this.ratingTop;
    data['ratings_count'] = this.ratingsCount;
    data['reviews_text_count'] = this.reviewsTextCount;
    data['added'] = this.added;
    data['metacritic'] = this.metacritic;
    data['playtime'] = this.playtime;
    data['suggestions_count'] = this.suggestionsCount;
    data['updated'] = this.updated;
    data['reviews_count'] = this.reviewsCount;
    data['saturated_color'] = this.saturatedColor;
    data['dominant_color'] = this.dominantColor;
    return data;
  }
}