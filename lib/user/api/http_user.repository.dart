// Dart imports:
import 'dart:async';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.service.dart';
import 'package:mangadex/user/api/user.client.dart';
import 'package:mangadex/user/api/user.mapper.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/domain/user.repository.dart';

User? _cachedUser;

@LazySingleton(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final UserClient _userClient;
  late final StreamSubscription _signOutSubscription;

  HttpUserRepository(this._userClient, AuthService authService) {
    _signOutSubscription = authService.onSignOut(_cleanCachedUser);
  }

  @override
  Future<User> fetchCurrentUser() async {
    if (_cachedUser != null) {
      return _cachedUser!;
    }

    final userResponseDto = await _userClient.me(includes: IncludesQuery(['scanlation_group']));
    _cachedUser = UserMapper.userDtoToUser(userResponseDto);

    return _cachedUser!;
  }

  void _cleanCachedUser(_) {
    _cachedUser = null;
  }

  @override
  void dispose() {
    _signOutSubscription.cancel();
  }
}
