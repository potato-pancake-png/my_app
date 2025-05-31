// filepath: c:\Users\Admin\Documents\Programming\my_app\lib\Model\auth_model.dart
class AuthModel {
  final String username; // id -> username
  final String password; // password -> pw
  final String nickname;

  AuthModel({
    required this.username,
    required this.password,
    required this.nickname,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'nickname': nickname,
  };
}
