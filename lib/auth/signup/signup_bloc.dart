import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth_repository.dart';
import '../login/form_submission_status.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepo;
  SignupBloc({this.authRepo}) : super(SignupState())  {
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
         await authRepo.signup();
         yield state.copyWith(formStatus: SubmissionSuccess());
       } catch (e) {
         yield state.copyWith(formStatus: SubmissionFailed(e));
       }
     }
    }
  }
}
