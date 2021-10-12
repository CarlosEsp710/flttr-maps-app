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

class ManualRoute extends MapEvent {
  final List<LatLng> route;
  final double distance;
  final double duration;

  ManualRoute({
    required this.route,
    required this.distance,
    required this.duration,
  });
}
