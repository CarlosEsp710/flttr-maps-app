part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawRoute;
  final bool startTracking;
  final LatLng? centralLocation;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapState({
    this.mapReady = false,
    this.drawRoute = true,
    this.startTracking = false,
    this.centralLocation,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : polylines = polylines ?? {},
        markers = markers ?? {};

  MapState copyWith({
    bool? mapReady,
    bool? drawRoute,
    bool? startTracking,
    LatLng? centralLocation,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        mapReady: mapReady ?? this.mapReady,
        drawRoute: drawRoute ?? this.drawRoute,
        startTracking: startTracking ?? this.startTracking,
        centralLocation: centralLocation ?? this.centralLocation,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
      );
}
