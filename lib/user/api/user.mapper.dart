// Project imports:
import 'package:mangadex/user/api/dto/user.dto.dart';
import 'package:mangadex/user/domain/user.dart';

class UserMapper {
  static User userDtoToUser(UserResponseDTO userResponseDTO) {
    return User(
      id: userResponseDTO.data.id,
      username: userResponseDTO.data.attributes.username,
      roles: userResponseDTO.data.attributes.roles,
      avatar: 'https://mangadex.org/img/avatar.png'
    );
  }
}
