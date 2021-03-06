part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnLoadedMap extends MapEvent {}

class OnDrawedRoute extends MapEvent {}

class OnFollowedLocation extends MapEvent {}

class OnCreateStartingRoute extends MapEvent {
  final List<LatLng> routeCoordinates;
  final double distance;
  final double duration;

  OnCreateStartingRoute(this.routeCoordinates, this.distance, this.duration);
}

class OnMovedMap extends MapEvent {
  final LatLng centerMap;

  OnMovedMap(this.centerMap);
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;

  OnLocationUpdate(this.location);
}
