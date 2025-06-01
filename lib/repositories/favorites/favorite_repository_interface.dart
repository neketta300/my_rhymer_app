import 'models/favorite_rhymes.dart';

abstract interface class FavoriteRepositoryI {
  Future<List<FavoriteRhymes>> getRhymesList();
  Future<void> createOrDeleteRhymes(FavoriteRhymes rhymes);
  Future<void> clear();
}
