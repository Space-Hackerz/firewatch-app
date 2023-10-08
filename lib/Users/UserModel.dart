class User{
  int userId;
  String userName;
  String userPassword;

  User({required this.userId, required this.userName, required this.userPassword});

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: int.parse(json["user_id"]),
    userName: json["user_name"],
    userPassword: json["user_password"]
  );

}