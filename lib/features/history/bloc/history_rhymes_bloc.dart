import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/repositories/history/history.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'history_rhymes_event.dart';
part 'history_rhymes_state.dart';

class HistoryRhymesBloc extends Bloc<HistoryRhymesEvent, HistoryRhymesState> {
  final HistoryRepositoryI _historyRepository;
  final Talker _talker;
  HistoryRhymesBloc({
    required HistoryRepositoryI historyRepository,
    required Talker talker,
  }) : _historyRepository = historyRepository,
       _talker = talker,
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
    } catch (e, st) {
      emit(HistoryRhymesFailure(error: e.toString()));
      _talker.handle(e, st);
    }
  }

  Future<void> _onClearRhymesHistory(
    ClearRhymesHistory event,
    Emitter<HistoryRhymesState> emit,
  ) async {
    try {
      await _historyRepository.clear();
      add(LoadHistoryRhymes());
    } catch (e, st) {
      emit(HistoryRhymesFailure(error: e.toString()));
      _talker.handle(e, st);
    }
  }
}
