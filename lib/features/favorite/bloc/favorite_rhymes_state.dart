part of 'favorite_rhymes_bloc.dart';

sealed class FavoriteRhymesState extends Equatable {
  const FavoriteRhymesState();

  @override
  List<Object> get props => [];
}

final class FavoriteRhymesInitial extends FavoriteRhymesState {}

final class FavoriteRhymesLoading extends FavoriteRhymesState {}

final class FavoriteRhymesLoaded extends FavoriteRhymesState {
  const FavoriteRhymesLoaded({required this.rhymes});
  final List<FavoriteRhymes> rhymes;

  @override
  List<Object> get props => super.props..addAll(rhymes);
}

final class FavoriteRhymesFailure extends FavoriteRhymesState {
  const FavoriteRhymesFailure({required this.error});
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
