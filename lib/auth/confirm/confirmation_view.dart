import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/auth/login/form_submission_status.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import 'confirmation_bloc.dart';


class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConfirmationBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>()
        ),
        child: _confirmationForm()
      ),
    );
  }
  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
         // _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child:
      Form( key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
              children: [
                _codeField(),
                _confirmationButton(),
              ]
          ),
        ),
      )
    );
  }
  Widget _codeField() {
    return BlocBuilder(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(icon: Icon(Icons.person), hintText: 'Confirmation Code'),
        validator: (value) => state.isValidCode ? null : 'Invalid Confirmation Code',
        onChanged: (value) => context.read<ConfirmationBloc>().add(
            ConfirmationCodeChanged(code: value)),
      );}
    );
  }
  Widget _confirmationButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting ? CircularProgressIndicator() :
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              child: const Text('Confirm'),
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                }
              },
            ),
          );
        });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}