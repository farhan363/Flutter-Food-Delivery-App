//import '..auth/login/form_submission_status.dart';
part of 'login_bloc.dart';
@immutable
class LoginState {
  final String email;
  bool get isValidEmail => email.length >= 8;
  //bool get isValidEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  final String password;
  bool get isValidPassword => password.length >= 8;
  //bool get isValidPassword => RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
  final FormSubmissionStatus formStatus;
  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({String email, String password, FormSubmissionStatus formStatus }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus);

  }
}
