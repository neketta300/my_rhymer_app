// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rhymes_list_bloc.dart';

sealed class RhymesListState extends Equatable {
  const RhymesListState();

  @override
  List<Object> get props => [];
}

final class RhymesListInitial extends RhymesListState {}

final class RhymesListLoading extends RhymesListState {}

final class RhymesListLoaded extends RhymesListState {
  const RhymesListLoaded({
    required List<FavoriteRhymes> favoriteRhymes,
    required this.queryWord,
    required this.rhymes,
  }) : _favoriteRhymes = favoriteRhymes;

  final Rhymes rhymes;
  final String queryWord;
  final List<FavoriteRhymes> _favoriteRhymes;

  bool isFavorite(String rhyme) {
    return _favoriteRhymes
        .where((e) => e.favoriteWord == rhyme && e.queryWord == queryWord)
        .isNotEmpty;
  }

  @override
  List<Object> get props =>
      super.props..addAll([rhymes, queryWord, _favoriteRhymes]);

  RhymesListLoaded copyWith({
    Rhymes? rhymes,
    String? queryWord,
    List<FavoriteRhymes>? favoriteRhymes,
  }) {
    return RhymesListLoaded(
      rhymes: rhymes ?? this.rhymes,
      queryWord: queryWord ?? this.queryWord,
      favoriteRhymes: favoriteRhymes ?? _favoriteRhymes,
    );
  }
}

final class RhymesListFailure extends RhymesListState {
  const RhymesListFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
