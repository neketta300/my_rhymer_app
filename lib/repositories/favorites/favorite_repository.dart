import 'package:realm/realm.dart';

import 'favorites.dart';

class FavoriteRepository implements FavoriteRepositoryI {
  FavoriteRepository({required this.realm});
  final Realm realm;

  @override
  Future<void> clear() async {
    realm.write(() => realm.deleteAll<FavoriteRhymes>());
  }

  @override
  Future<List<FavoriteRhymes>> getRhymesList() async {
    return realm.all<FavoriteRhymes>().toList();
  }

  @override
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes) async {
    final rhymeList = realm.query<FavoriteRhymes>(
      "queryWord == '${rhymes.queryWord}'AND favoriteWord == '${rhymes.favoriteWord}'",
    );
    if (rhymeList.isNotEmpty) {
      for (var e in rhymeList) {
        realm.write(() => realm.delete(e));
      }
      return;
    }
    realm.write(() => realm.add(rhymes));
  }
}
