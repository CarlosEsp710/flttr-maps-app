part of 'location_bloc.dart';

@immutable
class LocationState {
  final bool follow;
  final bool theresLocation;
  final LatLng? location;

  const LocationState({
    this.follow = true,
    this.theresLocation = false,
    this.location,
  });

  LocationState copyWith({
    bool? follow,
    bool? theresLocation,
    LatLng? location,
  }) =>
      LocationState(
        follow: follow ?? this.follow,
        theresLocation: theresLocation ?? this.theresLocation,
        location: location ?? this.location,
      );
}
