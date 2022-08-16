import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../login/form_submission_status.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  ConfirmationBloc({this.authRepo, this.authCubit }) : super(ConfirmationState());
    //on<ConfirmationEvent>((event, emit) {
      // TODO: implement event handler
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final userId = await authRepo.ConfirmSignup(
          email: authCubit.credentials.email,
          confirmationCode: state.code
        );
        print(userId);
        await authRepo.ConfirmSignup(email: authCubit.credentials.email, confirmationCode: state.code);
        yield state.copyWith(formStatus: SubmissionSuccess());
        final credentials = authCubit.credentials;
        credentials.userId = userId;
        authCubit.launchSession(credentials);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }

}
