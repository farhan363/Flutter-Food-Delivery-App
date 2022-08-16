import 'package:flutter/foundation.dart';

class AuthCredentials {
  final String email;
  final String password;
  String userId;

  AuthCredentials({
    this.email,
    this.password,
    @required userId});
}