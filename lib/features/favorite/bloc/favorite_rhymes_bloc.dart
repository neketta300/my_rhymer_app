import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../repositories/favorites/favorites.dart';

part 'favorite_rhymes_event.dart';
part 'favorite_rhymes_state.dart';

class FavoriteRhymesBloc
    extends Bloc<FavoriteRhymesEvent, FavoriteRhymesState> {
  final FavoriteRepositoryI _favoriteRepository;
  final Talker _talker;
  FavoriteRhymesBloc({
    required Talker talker,
    required FavoriteRepositoryI favoriteRepository,
  }) : _favoriteRepository = favoriteRepository,
       _talker = talker,
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
    } catch (e, st) {
      emit(FavoriteRhymesFailure(error: e.toString()));
      _talker.handle(e, st);
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhyme event,
    Emitter<FavoriteRhymesState> emit,
  ) async {
    try {
      _favoriteRepository.createOrDeleteRhymes(event.favoriteRhyme);
      add(LoadFavoriteRhymes());
    } catch (e, st) {
      _talker.handle(e, st);
    }
  }
}
