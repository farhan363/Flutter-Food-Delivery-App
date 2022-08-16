import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/screens/loginScreen.dart';

import '../screens/landingScreen.dart';
import 'auth_cubit.dart';
import 'confirm/confirmation_view.dart';
import 'signup/signup_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
            pages: [
              if (state == AuthState.login) MaterialPage(child: LoginScreen()),
              if (state == AuthState.signup || state == AuthState.confirmSignup) ...[
                MaterialPage(child: SignupView()),
                if(state == AuthState.confirmSignup) MaterialPage(child: ConfirmationView()),
              ]
            ],
            onPopPage: (route, result) => route.didPop(result));
      },
    );
  }
}