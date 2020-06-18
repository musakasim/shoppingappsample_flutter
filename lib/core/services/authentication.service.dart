class AuthenticationService {
  Future<bool> login(String userName) async {
    await Future.delayed(Duration(microseconds: 1500));

    return true;
  }
}
