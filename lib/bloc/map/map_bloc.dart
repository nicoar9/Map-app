import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:map_app/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  Polyline _myRoute = Polyline(
      polylineId: PolylineId('my_route'), width: 4, color: Colors.black87);

  void initMap(GoogleMapController controller) {
    if (!state.readyMap) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnLoadedMap());
    }
  }

  void moveCamera(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnLoadedMap) {
      yield state.copyWith(readyMap: true);
    } else if (event is OnLocationUpdate) {
      List<LatLng> points = [...this._myRoute.points, event.location];
      this._myRoute = this._myRoute.copyWith(pointsParam: points);
      final currentPolylines = state.polylines;
      currentPolylines['my_route'] = this._myRoute;
      yield state.copyWith(polylines: currentPolylines);
    } else if (event is OnDrawedRoute) {
      if (!state.drawRoute) {
        this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
      } else {
        this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
      }
      final currentPolylines = state.polylines;
      currentPolylines['my_route'] = this._myRoute;
      yield state.copyWith(
          drawRoute: !state.drawRoute, polylines: currentPolylines);
    }
  }
}
