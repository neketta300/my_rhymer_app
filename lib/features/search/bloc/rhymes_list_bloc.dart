import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/api/api.dart';
import 'package:my_rhymer/api/models/rhymes.dart';

part 'rhymes_list_event.dart';
part 'rhymes_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc(this.apiClient) : super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymeApiClient apiClient;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await apiClient.getRhymesList(event.query);
      emit(RhymesListLoaded(rhymes: rhymes));
    } catch (e) {
      emit(RhymesListFailure(error: e));
    }
  }
}
