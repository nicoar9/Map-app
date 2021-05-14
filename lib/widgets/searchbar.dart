part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return SizedBox();
        } else {
          return FadeInDown(
              duration: Duration(milliseconds: 250),
              child: buildSearchBar(context));
        }
      },
    );
  }

  buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximity =
                BlocProvider.of<MyLocationBloc>(context).state.location;

            final result = await showSearch(
              context: context,
              delegate: SearchDestination(proximity),
            );
            this.returnSearch(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
            child: Text(
              'Where do you want to go?',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }

  void returnSearch(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if (result.cancelled) return;
    if (result.manual) {
      searchBloc.add(OnEnabledManualMarker());

      return;
    }

    loadingAlert(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final startDestination =
        BlocProvider.of<MyLocationBloc>(context).state.location;
    final finalDestination = result.location;

    final drivingResponse = await trafficService.getCoordsStartToEnd(
        startDestination, finalDestination);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> routeCoordinates = points.decodedCoords
        .map(
          (point) => LatLng(point[0], point[1]),
        )
        .toList();

    mapBloc.add(
      OnCreateStartingRoute(routeCoordinates, distance, duration),
    );

    Navigator.of(context).pop();
  }
}
