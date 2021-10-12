part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manual;

  const SearchState({
    this.manual = false,
  });

  SearchState copyWith({
    bool? manual,
  }) =>
      SearchState(manual: manual ?? this.manual);
}
