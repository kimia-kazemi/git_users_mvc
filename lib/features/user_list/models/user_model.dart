class UserModel {
  final int id;
  final String name;
  final String avatar;
  final String htmlUrl;

  UserModel({required this.id, required this.name, required this.avatar,required this.htmlUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatar: json['avatar_url'],
      name: json['login'],
      htmlUrl: json['html_url'],
    );
  }
}
