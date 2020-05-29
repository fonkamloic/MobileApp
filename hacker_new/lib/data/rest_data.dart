import 'dart:async';
import 'package:hacker_new/utils/network_util.dart';

class RestData {
  NetworkUtil _networkUtil = NetworkUtil();

  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String username, String password) {
    return null;
  }
}
