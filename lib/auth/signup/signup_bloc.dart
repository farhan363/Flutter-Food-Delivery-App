import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../login/form_submission_status.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  SignupBloc({this.authRepo, this.authCubit}) : super(SignupState())  {
    @override
     Stream<SignupState> mapToState(SignupEvent event) async* {
      // TODO: implement event handler
     if (event is SignupEmailChanged) {
       yield state.copyWith(email: event.email);
     } else if (event is SignupPasswordChanged) {
       yield state.copyWith(email: event.password);
     } else if(event is SignupSubmitted) {
       yield state.copyWith(formStatus: FormSubmitting());
       try {
         await authRepo.signup(uid: 'xxxxx', email: state.email, password: state.password);
         yield state.copyWith(formStatus: SubmissionSuccess());
         authCubit.showConfirmSignup(
             email: state.email,
             password: state.password,
             confpassword: state.confpassword,
         );
       } catch (e) {
         yield state.copyWith(formStatus: SubmissionFailed(e));
       }
     }
    }
  }
}
