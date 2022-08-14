part of 'signup_bloc.dart';

@immutable
class SignupState {
  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;
  SignupState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignupState copyWith({String email, String password, FormSubmissionStatus formStatus }) {
    return SignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}

class SignupInitial extends SignupState {}
