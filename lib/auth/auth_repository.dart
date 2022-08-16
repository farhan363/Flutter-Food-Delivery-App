class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1) );
    throw Exception('not Signed IN !');
  }
  Future<String> login({
    String email,
    String password }) async {
    print('attempting Login ...');
      await Future.delayed(Duration(seconds: 3));
   return 'Loggedin';

  }
  Future<void> signup({String uid, String email, String password, String confpassword}) async {
    await Future.delayed(Duration(seconds: 3));
  }
  Future<String> ConfirmSignup({
      String email, String password,
      String confirmationCode}
      ) async {
    await Future.delayed(Duration(seconds: 3));
    return 'abc';
  }
  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 3));
  }
}