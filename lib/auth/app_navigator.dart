import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkey_app_demo/auth/session_state.dart';
import 'package:monkey_app_demo/screens/loginScreen.dart';

import '../loading_view.dart';
import '../screens/landingScreen.dart';
import '../session_cubit.dart';
import '../session_view.dart';
import 'auth_cubit.dart';
import 'auth_navigator.dart';
import 'auth_repository.dart';
import 'confirm/confirmation_view.dart';
import 'signup/signup_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
            pages: [
              if (state is UnknownSessionState) MaterialPage(child: LoadingView()),
              if (state is Unauthenticated) MaterialPage(
                  child: BlocProvider(
                    create: (context) => AuthCubit(
                        sessionCubit: context.read<SessionCubit>()),
                    child: AuthNavigator(),
                  )
              ),
              if (state is Authenticated) MaterialPage(child: SessionView())
            ],
            onPopPage: (route, result) => route.didPop(result)
        );
      },
    );
  }
}