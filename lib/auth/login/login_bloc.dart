import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../auth_repository.dart';
import 'form_submission_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({this.authRepo}) : super(LoginState()) {
    //on<LoginEvent>((event, emit)
    @override
    Stream<LoginState> mapEventToState(LoginEvent event) async* {
      // TODO: implement event handler
      if (event is LoginEmailChanged) {
        yield state.copyWith(email: event.email);
      } else if (event is LoginPasswordChanged) {
        yield state.copyWith(email: event.password);
      } else if (event is LoginSubmitted) {
        yield state.copyWith(formStatus: FormSubmitting());
        try {
          await authRepo.login();
          yield state.copyWith(formStatus: SubmissionSuccess());
        } catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }
    }
  }
}
