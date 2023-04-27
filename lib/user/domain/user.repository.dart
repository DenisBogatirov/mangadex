// Project imports:
import 'user.dart';

abstract class UserRepository {
  Future<User> fetchCurrentUser();
}
