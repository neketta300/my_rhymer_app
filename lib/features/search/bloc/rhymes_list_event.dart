part of 'rhymes_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object> get props => [];
}

class SearchRhymes extends RhymesListEvent {
  const SearchRhymes({required this.query});

  final String query;

  @override
  List<Object> get props => super.props..addAll([query]);
}

class ToggleFavoriteRhymes extends RhymesListEvent {
  const ToggleFavoriteRhymes({
    required this.completer,
    required this.queryWord,
    required this.favoriteWord,
    required this.rhymes,
  });
  final Rhymes rhymes;
  final String queryWord;
  final String favoriteWord;
  final Completer? completer;

  @override
  List<Object> get props =>
      super.props..add([rhymes, queryWord, favoriteWord, completer]);
}
