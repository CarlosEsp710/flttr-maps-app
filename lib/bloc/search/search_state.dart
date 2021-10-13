part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manual;
  final List<SearchResult> history;

  SearchState({
    this.manual = false,
    List<SearchResult>? history,
  }) : history = (history == null) ? [] : history;

  SearchState copyWith({
    bool? manual,
    List<SearchResult>? history,
  }) =>
      SearchState(
        manual: manual ?? this.manual,
        history: history ?? this.history,
      );
}
