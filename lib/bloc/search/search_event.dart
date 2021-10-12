part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class ActivatePinManual extends SearchEvent {}

class DesactivatePinManual extends SearchEvent {}
