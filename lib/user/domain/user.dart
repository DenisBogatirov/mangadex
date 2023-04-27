// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum UserRole {
  user('ROLE_USER');

  final String value;

  const UserRole(this.value);
}


class User extends Equatable {
  final String id;
  final String username;
  final List<UserRole> roles;
  final String? avatar;

  const User({
    required this.id,
    required this.username,
    required this.roles,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id];
}

class GuestUser extends User {
  GuestUser() : super(id: 'guest', username: 'Guest', roles: [], avatar: null);
}
