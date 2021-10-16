part of 'widgets.dart';

class PinManual extends StatelessWidget {
  const PinManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manual) return const _BuildPinManual();

        return Container();
      },
    );
  }
}

class _BuildPinManual extends StatelessWidget {
  const _BuildPinManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final blocSearch = BlocProvider.of<SearchBloc>(context);

    return Stack(
      children: <Widget>[
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                ),
                onPressed: () => blocSearch.add(DesactivatePinManual()),
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: const Offset(0, -20),
            child: BounceInDown(
              child: const Icon(
                Icons.location_on,
                size: 40,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 140,
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: const Text(
                'Confirmar destino',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => destination(context),
            ),
          ),
        ),
      ],
    );
  }

  void destination(BuildContext context) async {
    alert(context);

    final trafficService = TrafficService();

    final start = BlocProvider.of<LocationBloc>(context).state.location;
    final destination = BlocProvider.of<MapBloc>(context).state.centralLocation;

    final infoDestination = await trafficService.getCoordsInfo(destination!);

    final blocMap = BlocProvider.of<MapBloc>(context);

    final trafficResponse = await trafficService.getCoords(
      start!,
      destination,
    );

    final route = trafficResponse.routes[0];

    final points = poly.Polyline.Decode(
      encodedString: route.geometry,
      precision: 6,
    ).decodedCoords;

    final List<LatLng> routeCoords =
        points.map((point) => LatLng(point[0], point[1])).toList();

    blocMap.add(ManualRoute(
      route: routeCoords,
      distance: route.distance,
      duration: route.duration,
      destination: infoDestination.features![0].textEs,
    ));

    Navigator.of(context).pop();

    BlocProvider.of<SearchBloc>(context).add(DesactivatePinManual());
  }
}
