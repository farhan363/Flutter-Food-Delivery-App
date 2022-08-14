import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth_repository.dart';
import '../login/form_submission_status.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  ConfirmationBloc({this.authRepo}) : super(ConfirmationState());
    //on<ConfirmationEvent>((event, emit) {
      // TODO: implement event handler
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ConfirmationSubmitted) {
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
