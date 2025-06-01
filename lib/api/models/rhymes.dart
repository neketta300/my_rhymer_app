import 'package:json_annotation/json_annotation.dart';
import 'package:my_rhymer/repositories/favorites/models/favorite_rhymes.dart';
import 'package:uuid/uuid.dart';

import '../../repositories/history/models/history_rhymes.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhymes {
  const Rhymes({required this.rhymes});

  factory Rhymes.fromJson(Map<String, dynamic> json) => _$RhymesFromJson(json);

  final List<String> rhymes;

  Map<String, dynamic> toJson() => _$RhymesToJson(this);

  HistoryRhymes toHisroty(String queryWord) {
    var uuid = const Uuid();
    return HistoryRhymes(uuid.v4(), queryWord, rhymes: rhymes);
  }

  FavoriteRhymes toFavorite(String queryWord, String favoriteWord) {
    var uuid = const Uuid();
    return FavoriteRhymes(
      uuid.v4(),
      queryWord,
      favoriteWord,
      DateTime.now(),
      rhymes: rhymes,
    );
  }
}
