import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:maps/models/search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<ActivatePinManual>((event, emit) => emit(state.copyWith(manual: true)));
    on<DesactivatePinManual>(
        (event, emit) => emit(state.copyWith(manual: false)));
    on<AddHistory>((event, emit) {
      final existing = state.history
          .where((result) => result.name == event.result.name)
          .length;

      if (existing == 0) {
        final newHistory = [...state.history, event.result];
        emit(state.copyWith(history: newHistory));
      }
    });
  }
}
