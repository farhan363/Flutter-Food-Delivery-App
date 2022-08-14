import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/auth/auth_repository.dart';
import 'package:monkey_app_demo/screens/forgetPwScreen.dart';

import '../auth/login/form_submission_status.dart';
import '../auth/login/login_bloc.dart';
import '../const/colors.dart';
import '../screens/forgetPwScreen.dart';
import '../screens/signUpScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authRepo: context.read<AuthRepository>()),
        child: Stack(alignment: Alignment.bottomCenter,
          children: [
            BlocListener<LoginBloc, LoginState>(
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
                          _emailField(),
                          _passwordField(),
                          _loginButton(),
                        ]
                    ),
                  ),
                )
            ),
            _showSignUpButton(),
          ]
        ),
      ),
    );
  }
  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    return TextFormField(
      validator: (value) => state.isValidEmail ? null : 'Email Address not Valid'    ,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
          hintText: 'Email Address', ),
      onChanged: (value) => context.read<LoginBloc>().add(
          LoginEmailChanged(email: value)),
     
    );
  },
);
  }
  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    return TextFormField(
      validator: (value) => state.isValidPassword ?  null : 'Password not Valid',
      obscureText: true, obscuringCharacter: "*",
      decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password'),
      onChanged: (value) => context.read<LoginBloc>().add(
          LoginPasswordChanged(password: value)),
    );
  },
);
  }
  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting ? CircularProgressIndicator() :
         Padding(
           padding: const EdgeInsets.all(18.0),
           child: ElevatedButton(
            child: const Text('Login'),
            onPressed: (){
              if (_formKey.currentState.validate()) {
                context.read<LoginBloc>().add(LoginSubmitted());
              }
            },
        ),
         );
      });
  }
  Widget _showSignUpButton() {
      return SafeArea(
          child: TextButton(
              child: Text('Don\'t have an account? Sign up here'),
            onPressed: () {},)
      );
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
