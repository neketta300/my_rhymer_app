import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/api/models/rhymes.dart';
import 'package:my_rhymer/api/rhymes_api.dart';
import 'package:my_rhymer/repositories/favorites/favorites.dart';
import 'package:my_rhymer/repositories/history/history.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({
    required Talker talker,
    required RhymeApiClient apiClient,
    required HistoryRepositoryI historyRepository,
    required FavoriteRepositoryI favoriteRepository,
  }) : _historyRepository = historyRepository,
       _apiClient = apiClient,
       _talker = talker,
       _favoriteRepository = favoriteRepository,
       super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteRhymes>(_onToggleFavorite);
  }
  final HistoryRepositoryI _historyRepository;
  final RhymeApiClient _apiClient;
  final FavoriteRepositoryI _favoriteRepository;
  final Talker _talker;
  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHisroty(event.query);
      await _historyRepository.setRhymes(historyRhymes);
      final favoriteRhymes = await _favoriteRepository.getRhymesList();

      emit(
        RhymesListLoaded(
          rhymes: rhymes,
          queryWord: event.query,
          favoriteRhymes: favoriteRhymes,
        ),
      );
    } catch (e, st) {
      emit(RhymesListFailure(error: e));
      _talker.handle(e, st);
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      final prevState = state;
      if (prevState is! RhymesListLoaded) return;

      await _favoriteRepository.createOrDeleteRhymes(
        event.rhymes.toFavorite(event.queryWord, event.favoriteWord),
      );

      final favoriteRhymes = await _favoriteRepository.getRhymesList();
      emit(prevState.copyWith(favoriteRhymes: favoriteRhymes));
    } catch (e, st) {
      _talker.handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }
}
