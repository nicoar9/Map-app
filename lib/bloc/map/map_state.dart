part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;
  final bool followLocation;
  final LatLng centralLocation;

  final Map<String, Polyline> polylines;

  MapState({
    this.readyMap = false,
    this.centralLocation,
    this.drawRoute = false,
    Map<String, Polyline> polylines,
    this.followLocation = false,
  }) : this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool readyMap,
    bool drawRoute,
    Map<String, Polyline> polylines,
    bool followLocation,
    LatLng centralLocation,
  }) =>
      MapState(
        readyMap: readyMap ?? this.readyMap,
        polylines: polylines ?? this.polylines,
        drawRoute: drawRoute ?? this.drawRoute,
        followLocation: followLocation ?? this.followLocation,
        centralLocation: centralLocation ?? this.centralLocation,
      );
}
