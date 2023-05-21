// Project imports:
import 'package:mangadex/manga/domain/manga.dart';

extension CoverArtExtension on Manga {
  String get coverArt256 => '$coverArt.256.jpg';
  String get coverArt512 => '$coverArt.512.jpg';
}
