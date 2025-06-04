import 'package:realm/realm.dart';

import 'history.dart';

class HistoryRepository implements HistoryRepositoryI {
  HistoryRepository({required this.realm});
  final Realm realm;

  @override
  Future<void> clear() async {
    realm.write(() => realm.deleteAll<HistoryRhymes>());
  }

  @override
  Future<List<HistoryRhymes>> getRhymesList() async {
    return realm.all<HistoryRhymes>().toList();
  }

  @override
  Future<void> setRhymes(HistoryRhymes rhymes) async {
    realm.write(() => realm.add<HistoryRhymes>(rhymes));
  }
}
