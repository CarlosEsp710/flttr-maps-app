import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<ChangeLocation>((event, emit) =>
        emit(state.copyWith(theresLocation: true, location: event.location)));
  }

  StreamSubscription<Geolocator.Position>? _positionSubscription;

  void startTracking() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: Geolocator.LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Geolocator.Position position) {
      final newPosition = LatLng(position.latitude, position.longitude);
      add(ChangeLocation(newPosition));
    });
  }

  void stopTracking() {
    _positionSubscription!.cancel();
  }
}
