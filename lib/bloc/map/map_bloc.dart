import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart' show Colors;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/themes/map_style.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<MapReady>((event, emit) => emit(state.copyWith(mapReady: true)));
    on<UpdateLocation>((event, emit) => emit(_updateLocation(event)));
    on<DrawRoute>((event, emit) => emit(_drawRoute(event)));
    on<StartTracking>((event, emit) => emit(_startTracking(event)));
    on<MoveMap>((event, emit) =>
        emit(state.copyWith(centralLocation: event.centralLocation)));
  }

  GoogleMapController? _mapController;
  Polyline _myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
    color: Colors.black87,
  );

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) _mapController = controller;

    _mapController!.setMapStyle(jsonEncode(mapTheme));

    add(MapReady());
  }

  void moveCamera(LatLng location) {
    final cameraUpdate = CameraUpdate.newLatLng(location);
    _mapController!.animateCamera(cameraUpdate);
  }

  MapState _updateLocation(UpdateLocation event) {
    if (state.startTracking) moveCamera(event.location);

    final points = [..._myRoute.points, event.location];
    _myRoute = _myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = _myRoute;

    return state.copyWith(polylines: currentPolylines);
  }

  MapState _drawRoute(DrawRoute event) {
    (!state.drawRoute)
        ? _myRoute = _myRoute.copyWith(colorParam: Colors.black87)
        : _myRoute = _myRoute.copyWith(colorParam: Colors.transparent);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = _myRoute;

    return state.copyWith(
      drawRoute: !state.drawRoute,
      polylines: currentPolylines,
    );
  }

  MapState _startTracking(StartTracking event) {
    if (!state.startTracking) {
      moveCamera(_myRoute.points[_myRoute.points.length - 1]);
    }

    return state.copyWith(startTracking: !state.startTracking);
  }
}
