part of 'signup_bloc.dart';

@immutable
class SignupState {
  final String email;
  bool get isValidEmail => email.length <= 8;

  final String password;
  bool get isValidpassword => password.length <= 6;
  final String confpassword;
  bool get isValidconfpassword => confpassword.length <= 6;
  final FormSubmissionStatus formStatus;
  SignupState({
    this.email = '',
    this.password = '',
    this.confpassword = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignupState copyWith({String email, String password, FormSubmissionStatus formStatus }) {
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        confpassword: confpassword ?? this.confpassword,
        formStatus: formStatus ?? this.formStatus);
  }
}

class SignupInitial extends SignupState {}
