import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../session_cubit.dart';
import 'auth_credentials.dart';


enum AuthState { login, signup, confirmSignup}

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials credentials;
  void showLogin() => emit(AuthState.login);
  void showSignup() => emit(AuthState.signup);
  void showConfirmSignup({
    String email,
    String password,
    String confpassword,
  }) {emit(AuthState.confirmSignup);
  }
  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
