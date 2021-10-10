import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/themes/map_style.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<MapReady>((event, emit) => emit(state.copyWith(mapReady: true)));
  }

  GoogleMapController? _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) _mapController = controller;

    _mapController!.setMapStyle(jsonEncode(mapTheme));

    add(MapReady());
  }

  void moveCamera(LatLng location) {
    final cameraUpdate = CameraUpdate.newLatLng(location);
    _mapController!.animateCamera(cameraUpdate);
  }
}
