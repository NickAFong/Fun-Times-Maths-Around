class UserModel {
  String? username;
  String? email;
  late String rank;

  UserModel({this.email, this.rank = "-1", this.username});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['username'] = username;
    json['email'] = email;
    json['rank'] = rank;
    return json;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    rank = json['rank'];
  }
}
