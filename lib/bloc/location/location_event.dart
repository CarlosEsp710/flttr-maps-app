part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class ChangeLocation extends LocationEvent {
  final LatLng location;

  ChangeLocation(this.location);
}
