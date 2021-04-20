import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';
import 'package:map_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<MyLocationBloc>(context).initTracking();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyLocationBloc>(context).disposeTracking();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MyLocationBloc, MyLocationState>(
            builder: (_, state) => createMap(state),
          ),

          // Positioned(
          //   top: 15,
          //   child: SearchBar(),
          // ),
          ManualMarker(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [BtnLocation(), BtnFollowLocation(), BtnMyRoute()],
      ),
    );
  }

  createMap(MyLocationState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (!state.existLocation)
      return Center(
        child: Text("Loading..."),
      );
    mapBloc.add(OnLocationUpdate(state.location));

    final cameraPosition = CameraPosition(target: state.location, zoom: 15);
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
      polylines: mapBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        mapBloc.add(OnMovedMap(cameraPosition.target));
      },
    );
  }
}
