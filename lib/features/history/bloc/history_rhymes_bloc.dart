import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_rhymer/repositories/history/history.dart';
import 'package:my_rhymer/repositories/history/models/history_rhymes.dart';

part 'history_rhymes_event.dart';
part 'history_rhymes_state.dart';

class HistoryRhymesBloc extends Bloc<HistoryRhymesEvent, HistoryRhymesState> {
  final HistoryRepositoryI _historyRepository;

  HistoryRhymesBloc({required HistoryRepositoryI historyRepository})
    : _historyRepository = historyRepository,
      super(HistoryRhymesInitial()) {
    on<LoadHistoryRhymes>(_onLoadHisrotyRhymes);
    on<ClearRhymesHistory>(_onClearRhymesHistory);
  }

  Future<void> _onLoadHisrotyRhymes(
    LoadHistoryRhymes event,
    Emitter<HistoryRhymesState> emit,
  ) async {
    try {
      emit(HistoryRhymesLoading());
      final rhymes = await _historyRepository.getRhymesList();
      emit(HistoryRhymesLoaded(rhymes: rhymes));
    } catch (e) {
      emit(HistoryRhymesFailure(error: e.toString()));
    }
  }

  Future<void> _onClearRhymesHistory(
    ClearRhymesHistory event,
    Emitter<HistoryRhymesState> emit,
  ) async {
    try {
      await _historyRepository.clear();
      add(LoadHistoryRhymes());
    } catch (e) {
      log(e.toString());
      // emit(HistoryRhymesFailure(error: e.toString()));
    }
  }
}
