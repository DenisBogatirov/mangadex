class WrongSignInCredentialsException implements Exception {
  final message = 'Wrong sign in credentials';

  @override
  String toString() => message;
}

class NotSignedInException implements Exception {
  final message = 'User is not signed in';

  @override
  String toString() => message;
}
