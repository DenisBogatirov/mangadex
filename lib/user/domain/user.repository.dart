// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'user.dart';

abstract class UserRepository {
  Future<User> fetchCurrentUser();

  @disposeMethod
  void dispose();
}
