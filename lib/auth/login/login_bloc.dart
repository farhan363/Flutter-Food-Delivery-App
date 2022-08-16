import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monkey_app_demo/auth/auth_credentials.dart';
import 'package:monkey_app_demo/auth/auth_cubit.dart';
import '../auth_repository.dart';
import 'form_submission_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState()) {
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
          final userId = await authRepo.login(
            email: state.email, password: state.password
          );
          await authRepo.login(email: state.email, password: state.password);
          yield state.copyWith(formStatus: SubmissionSuccess());
          authCubit.launchSession(AuthCredentials(userId: state.email));
        } catch (e) {
          yield state.copyWith(formStatus: SubmissionFailed(e));
        }
      }
    }
  }
}
