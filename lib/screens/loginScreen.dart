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
        child: BlocListener<LoginBloc, LoginState>(
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
      ),
      /* body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [


                Text(
                  "Login",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text('Add your details to login'),
                Spacer(),
                CustomTextInput(
                  hintText: "Your email",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "password",
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Login"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ForgetPwScreen.routeName);
                  },
                  child: Text("Forget your password?"),
                ),
                Spacer(
                  flex: 2,
                ),
                Text("or Login With"),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFF367FC0,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "fb.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Facebook")
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(
                          0xFFDD4B39,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "google.png",
                            "virtual",
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Login with Google")
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ), */
    );
  }
  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
  builder: (context, state) {
    return TextFormField(
      validator: (value) => state.isValidEmail ? null : 'Email Address not Valid',
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
      validator: (value) => state.isValidPassword ? null : 'Password not Valid',
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
        return state.formStatus is FormSubmitting ? CircularProgressIndicator()
            : ElevatedButton(
          child: const Text('Login'),
          onPressed: (){
            if (_formKey.currentState.validate()) {
              context.read<LoginBloc>().add(LoginSubmitted());
            }
          },
        );
      });
  }
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
