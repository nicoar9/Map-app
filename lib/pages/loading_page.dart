import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/helpers/helpers.dart';
import 'package:map_app/pages/gps_access_page.dart';
import 'package:map_app/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
          context,
          navegarMapaFadeIn(
            context,
            MapPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }
}

Future checkGpsLocation(BuildContext context) async {
  final gpsPermission = await Permission.location.isGranted;
  final gpsActive = await Geolocator.isLocationServiceEnabled();

  if (gpsPermission && gpsActive) {
    Navigator.pushReplacement(
      context,
      navegarMapaFadeIn(
        context,
        MapPage(),
      ),
    );
  }
  if (!gpsPermission) {
    Navigator.pushReplacement(
      context,
      navegarMapaFadeIn(
        context,
        GpsAccessPage(),
      ),
    );
  } else {
    return 'Please enable your GPS';
  }
}
