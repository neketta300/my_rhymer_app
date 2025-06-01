import 'package:my_rhymer/repositories/history/models/history_rhymes.dart';

abstract interface class HistoryRepositoryI {
  Future<List<HistoryRhymes>> getRhymesList();
  Future<void> setRhymes(HistoryRhymes rhymes);
  Future<void> clear();
}
