part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}
class SignupEmailChanged extends SignupEvent {
  final String email;

  SignupEmailChanged({this.email});
}
class SignupPasswordChanged extends SignupEvent {
  final String password;

  SignupPasswordChanged({this.password});
}
class SignupSubmitted extends SignupEvent {
}