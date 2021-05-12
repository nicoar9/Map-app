part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) =>
          state.manualSelection ? _BuildManualMarker() : SizedBox(),
    );
  }
}

class _BuildManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(
              milliseconds: 200,
            ),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  searchBloc.add(
                    OnDisabledManualMarker(),
                  );
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text(
                'Confirm Destination',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              color: Colors.black87,
              onPressed: () => getDestination(context),
            ),
          ),
        ),
      ],
    );
  }

  void getDestination(BuildContext context) async {
    loadingAlert(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final currentLocation =
        BlocProvider.of<MyLocationBloc>(context).state.location;

    final finalDestination = mapBloc.state.centralLocation;

    final trafficResponse = await trafficService.getCoordsStartToEnd(
        currentLocation, finalDestination);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    final List<LatLng> routeCoords =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapBloc.add(
      OnCreateStartingRoute(routeCoords, distance, duration),
    );

    Navigator.of(context).pop();
    BlocProvider.of<SearchBloc>(context).add(OnDisabledManualMarker());
  }
}
