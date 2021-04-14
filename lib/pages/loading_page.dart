import 'package:flutter/material.dart';
import 'package:map_app/helpers/helpers.dart';
import 'package:map_app/pages/gps_access_page.dart';
import 'package:map_app/pages/map_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          ));
        },
      ),
    );
  }
}

Future checkGpsLocation(BuildContext context) async {
  await Future.delayed(Duration(milliseconds: 200));

  // Navigator.pushReplacement(
  //   context,
  //   navegarMapaFadeIn(
  //     context,
  //     GpsAccessPage(),
  //   ),
  // );
  // Navigator.pushReplacement(
  //   context,
  //   navegarMapaFadeIn(
  //     context,
  //     MapaPage(),
  //   ),
  // );
}
