import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps/bloc/location/location_bloc.dart';
import 'package:maps/bloc/map/map_bloc.dart';

import 'package:maps/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<LocationBloc>(context).startTracking();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<LocationBloc>(context).stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocBuilder<LocationBloc, LocationState>(
            builder: (_, state) => createMap(state),
          ),
          const Positioned(
            top: 20,
            child: SearchBar(),
          ),
          const PinManual(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          BtnPolylines(),
          BtnTracking(),
          BtnLocation(),
        ],
      ),
    );
  }

  Widget createMap(LocationState state) {
    if (!state.theresLocation) return const Center(child: Text('Ubicando...'));

    final cameraPosition = CameraPosition(target: state.location, zoom: 15);
    final blocMap = BlocProvider.of<MapBloc>(context);
    blocMap.add(UpdateLocation(state.location!));

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: blocMap.initMap,
          polylines: blocMap.state.polylines.values.toSet(),
          markers: blocMap.state.markers.values.toSet(),
          onCameraMove: (cameraPosition) =>
              blocMap.add(MoveMap(cameraPosition.target)),
        );
      },
    );
  }
}
