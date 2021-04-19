part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool drawRoute;
  final bool followLocation;

  final Map<String, Polyline> polylines;

  MapState({
    this.readyMap = false,
    this.drawRoute = true,
    Map<String, Polyline> polylines,
    this.followLocation = false,
  }) : this.polylines = polylines ?? new Map();

  MapState copyWith(
          {bool readyMap,
          bool drawRoute,
          Map<String, Polyline> polylines,
          bool followLocation}) =>
      MapState(
        readyMap: readyMap ?? this.readyMap,
        polylines: polylines ?? this.polylines,
        drawRoute: drawRoute ?? this.drawRoute,
        followLocation: followLocation ?? this.followLocation,
      );
}
