import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/repositories/history/history.dart';

import '../../../repositories/favorites/favorites.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  final FavoriteRepositoryI _favoriteRepository;

  FavoriteRhymesBloc({
    required FavoriteRepositoryI favoriteRepository,
    required HistoryRepositoryI historyRepository,
  }) : _favoriteRepository = favoriteRepository,
       super(FavoriteRhymesInitial()) {
    on<LoadFavoriteRhymes>(_onLoadHisrotyRhymes);
    on<ToggleFavoriteRhyme>(_onToggleFavorite);
  }

  Future<void> _onLoadHisrotyRhymes(
    LoadFavoriteRhymes event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      emit(FavoriteRhymesLoading());
      final rhymes = await _favoriteRepository.getRhymesList();
      emit(FavoriteRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(FavoriteRhymesFailure(error: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhyme event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      _favoriteRepository.createOrDeleteRhymes(event.favoriteRhyme);
      add(LoadFavoriteRhymes());
    } catch (e) {
      log(e.toString());
    }
  }
}
