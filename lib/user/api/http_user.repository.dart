// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/user/api/user.client.dart';
import 'package:mangadex/user/api/user.mapper.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/domain/user.repository.dart';

@LazySingleton(as: UserRepository)
class HttpUserRepository implements UserRepository {
  final UserClient _userClient;

  HttpUserRepository(this._userClient);

  @override
  Future<User> fetchCurrentUser() async {
    final userResponseDto = await _userClient.me(includes: IncludesQuery(['scanlation_group']));
    return UserMapper.userDtoToUser(userResponseDto);
  }
}
