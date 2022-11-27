class ApiEndPoints{
  static const String _prodUrl = 'http://194.195.117.238';
  static const String _devUrl = "http://192.168.31.170:5500";
  static const String _baseUrl = _prodUrl;
  static const String _auth = '$_baseUrl/auth';

  static const String login = '$_auth/login';
  static const String signup = '$_auth/signup';

  static const String _user = '$_baseUrl/user';
  static const String allUsers = '$_user/all';

  static const String sendMessage = "$_baseUrl/message/send";
}