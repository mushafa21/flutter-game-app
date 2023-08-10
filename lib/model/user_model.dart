

class UserModel{
  int? id;
  String? name;


  UserModel({
    this.id = 0,
    this.name = "",
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'id': id,
        'name': name,
      };
}