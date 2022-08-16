import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/auth/auth_credentials.dart';

import 'auth/auth_repository.dart';
import 'auth/session_state.dart';
class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  SessionCubit({this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }
  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      final user = userId;
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }
  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    //final user = dataRepo.getUser(credentials.userId);
    final user = credentials.userId;
    emit(Authenticated(user: user));
  }
  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
