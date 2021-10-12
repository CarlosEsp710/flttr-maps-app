import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<ActivatePinManual>((event, emit) => emit(state.copyWith(manual: true)));
    on<DesactivatePinManual>(
        (event, emit) => emit(state.copyWith(manual: false)));
  }
}
