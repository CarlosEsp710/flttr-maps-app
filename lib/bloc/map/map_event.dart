part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapReady extends MapEvent {}

class UpdateLocation extends MapEvent {
  final LatLng location;

  UpdateLocation(this.location);
}

class DrawRoute extends MapEvent {}

class StartTracking extends MapEvent {}

class MoveMap extends MapEvent {
  final LatLng centralLocation;

  MoveMap(this.centralLocation);
}
