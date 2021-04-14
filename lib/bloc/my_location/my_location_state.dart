part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool tracing;
  final bool existLocation;
  final LatLng location;

  MyLocationState(
      {this.tracing = true, this.existLocation = false, this.location});

  MyLocationState copyWith({
    bool tracing,
    bool existLocation,
    LatLng location,
  }) =>
      new MyLocationState(
        tracing: tracing ?? this.tracing,
        existLocation: existLocation ?? this.existLocation,
        location: location ?? this.location,
      );
}
