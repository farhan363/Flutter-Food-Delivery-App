import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/auth/auth_repository.dart';
import 'package:monkey_app_demo/auth/signup/signup_bloc.dart';

import '../auth_cubit.dart';
import '../login/form_submission_status.dart';

class SignupView extends StatelessWidget {
  //static const routeName = "/loginScreen";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()
        ),
        child: Stack(alignment: Alignment.bottomCenter,
            children: [
              BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    final formStatus = state.formStatus;
                    if (formStatus is SubmissionFailed) {
                      _showSnackBar(context, formStatus.exception.toString());
                    }
                  },
                  //builder: (context, state) {
                  child: Form( key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                          children: [
                            Text(
                              'SIGNUP',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            _emailField(),
                            _passwordField(),
                            _confpasswordField(),
                            _signupButton(),
                          ]
                      ),
                    ),
                  )
              ),
              _showLoginButton(context),
            ]
        ),
      ),
    );
  }
  Widget _emailField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidEmail ? null : 'Email Address not Valid'    ,
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Email Address', ),
          onChanged: (value) => context.read<SignupBloc>().add(
              SignupEmailChanged(email: value)),

        );
      },
    );
  }
  Widget _passwordField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidpassword ?  null : 'Password not Valid',
          obscureText: true, obscuringCharacter: "*",
          decoration: const InputDecoration(
              icon: Icon(Icons.security),
              hintText: 'Password'),
          onChanged: (value) => context.read<SignupBloc>().add(
              SignupPasswordChanged(password: value)),
        );
      },
    );
  }
  Widget _confpasswordField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidconfpassword ?  null : 'Password not Valid',
          obscureText: true, obscuringCharacter: "*",
          decoration: const InputDecoration(
              icon: Icon(Icons.security),
              hintText: 'Confirm Password'),
          onChanged: (value) => context.read<SignupBloc>().add(
              SignupPasswordChanged(password: value)),
        );
      },
    );
  }
  Widget _signupButton() {
    return BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting ? CircularProgressIndicator() :
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              child: const Text('SIGNUP'),
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  context.read<SignupBloc>().add(SignupSubmitted());
                }
              },
            ),
          );
        });
  }
  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
          child: Text('Already have an account? Login here'),
          onPressed: () => context.read<AuthCubit>().showLogin(),
        )
    );
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
