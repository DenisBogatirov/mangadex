// Package imports:
import 'package:equatable/equatable.dart';

abstract class SignInPayload extends Equatable {}

class UsernamePayload extends SignInPayload {
  final String username;
  final String password;
  final bool rememberMe;

  UsernamePayload({
    required this.username,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [username, password, rememberMe];
}

class AuthToken {
  final String sessionToken;
  final String? refreshToken;

  const AuthToken({
    required this.sessionToken,
    required this.refreshToken,
  });
}
