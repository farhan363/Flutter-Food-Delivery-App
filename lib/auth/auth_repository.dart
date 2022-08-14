class AuthRepository {
  Future<String> login({
    String email,
    String password }) async {
    print('attempting Login ...');
      await Future.delayed(Duration(seconds: 3));
   return 'Loggedin';

  }
  Future<void> signup({String uid, String email, String password}) async {
    await Future.delayed(Duration(seconds: 3));
  }
  Future<String> ConfirmSignup({
      String email, String passwor,
      String confirmationCode}
      ) async {
    await Future.delayed(Duration(seconds: 3));
    return 'abc';
  }
}